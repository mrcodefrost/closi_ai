import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.g.dart';
part 'user_profile_model.freezed.dart';

@freezed
@HiveType(typeId: 2)
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    @HiveField(0) required String id,
    @HiveField(1) required String clerkUserId, // Clerk user ID
    @HiveField(2) required String email,
    @HiveField(3) String? username,
    @HiveField(4) String? fullName,
    @HiveField(5) String? profileImageUrl,
    @HiveField(6) String? bodyImagePath, // Full body photo for try-on
    @HiveField(7) Map<String, dynamic>? bodyMeasurements, // From ML Kit pose detection
    @HiveField(8) String? gender,
    @HiveField(9) double? height,
    @HiveField(10) double? weight,
    @HiveField(11) String? bodyType,
    @HiveField(12) List<String>? stylePreferences,
    @HiveField(13) required DateTime createdAt,
    @HiveField(14) DateTime? updatedAt,
    @HiveField(15) Map<String, dynamic>? preferences,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}
