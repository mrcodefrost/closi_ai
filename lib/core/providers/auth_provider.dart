import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import '../../data/models/user_profile_model.dart';
import '../services/storage/hive_service.dart';
import 'package:logger/logger.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final _logger = Logger();
  final _clerk = Clerk.instance;
  
  Stream<Session?> get sessionStream => _clerk.sessionStream;
  Session? get currentSession => _clerk.session;
  User? get currentUser => _clerk.user;
  
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      final session = await _clerk.signIn(
        strategy: SignInStrategy.password,
        identifier: email,
        password: password,
      );
      
      if (session != null) {
        await _createOrUpdateUserProfile(session.user!);
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Sign in error: $e');
      return false;
    }
  }
  
  Future<bool> signUpWithEmail(String email, String password, String username) async {
    try {
      final signUp = await _clerk.signUp(
        emailAddress: email,
        password: password,
        username: username,
      );
      
      if (signUp != null) {
        // Verify email if needed
        if (signUp.status == SignUpStatus.missingRequirements) {
          // Handle email verification
          await signUp.prepareVerification(
            strategy: VerificationStrategy.emailCode,
          );
        }
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Sign up error: $e');
      return false;
    }
  }
  
  Future<bool> signInWithOAuth(OAuthProvider provider) async {
    try {
      final session = await _clerk.signInWithOAuth(
        provider: provider,
        redirectUrl: 'closi://oauth-callback',
      );
      
      if (session != null) {
        await _createOrUpdateUserProfile(session.user!);
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('OAuth sign in error: $e');
      return false;
    }
  }
  
  Future<void> signOut() async {
    try {
      await _clerk.signOut();
    } catch (e) {
      _logger.e('Sign out error: $e');
    }
  }
  
  Future<void> _createOrUpdateUserProfile(User clerkUser) async {
    try {
      final profile = UserProfileModel(
        id: clerkUser.id,
        clerkUserId: clerkUser.id,
        email: clerkUser.emailAddresses.first.emailAddress,
        username: clerkUser.username,
        fullName: clerkUser.fullName,
        profileImageUrl: clerkUser.imageUrl,
        createdAt: DateTime.now(),
      );
      
      await HiveService.userProfileBox.put(clerkUser.id, profile);
    } catch (e) {
      _logger.e('Error creating user profile: $e');
    }
  }
}

// Current user profile provider
final userProfileProvider = StreamProvider<UserProfileModel?>((ref) async* {
  final authService = ref.watch(authServiceProvider);
  
  await for (final session in authService.sessionStream) {
    if (session != null) {
      final profile = HiveService.userProfileBox.get(session.user!.id);
      yield profile;
    } else {
      yield null;
    }
  }
});
