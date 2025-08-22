import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import '../../features/onboarding/splash_screen.dart';
import '../../features/onboarding/welcome_screen.dart';
import '../../features/onboarding/auth_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/wardrobe/wardrobe_screen.dart';
import '../../features/profile/profile_screen.dart';
import 'auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isAuthRoute = state.matchedLocation == '/auth' || 
                         state.matchedLocation == '/welcome';
      
      if (!isAuthenticated && !isAuthRoute && state.matchedLocation != '/splash') {
        return '/welcome';
      }
      
      if (isAuthenticated && isAuthRoute) {
        return '/home';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/wardrobe',
        builder: (context, state) => const WardrobeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});

// Auth state provider
final authStateProvider = StreamProvider<AuthState>((ref) async* {
  final clerk = Clerk.instance;
  
  await for (final session in clerk.sessionStream) {
    if (session != null) {
      yield AuthState(
        isAuthenticated: true,
        userId: session.user?.id,
        email: session.user?.emailAddresses.firstOrNull?.emailAddress,
        name: session.user?.fullName,
      );
    } else {
      yield const AuthState(isAuthenticated: false);
    }
  }
});

class AuthState {
  final bool isAuthenticated;
  final String? userId;
  final String? email;
  final String? name;
  
  const AuthState({
    required this.isAuthenticated,
    this.userId,
    this.email,
    this.name,
  });
}
