import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';

class AppUser extends Equatable {
  final String id;
  final String email;
  bool hasPremium;
  final String? fullName;
  final String? userName;
  final String? dob;
  final String? phoneNumber;
  final String? occupation;
  final String? about;
  final String? profilePic;
  final String? location;
  final Timestamp? lastSeen;
  final NotificationPreferences notificationPreferences;
  final int visitedUserCount;
  final String token;
  final double? latitude;
  final double? longitude;
  int followersCount;
  int followingCount;
  // final List<String> followers;
  final List<String> following;
  final List<String> interests;
  final bool onlineStatus;
  final List<String> posts;
  final int viewedSetupIndex;

  AppUser({
    required this.id,
    this.viewedSetupIndex = 0,
    required this.notificationPreferences,
    required this.email,
    this.lastSeen,
    required this.hasPremium,
    required this.fullName,
    required this.userName,
    required this.onlineStatus,
    required this.dob,
    required this.followersCount,
    required this.followingCount,
    this.phoneNumber,
    this.occupation,
    this.about,
    this.profilePic,
    this.location,
    this.latitude,
    this.longitude,
    required this.visitedUserCount,
    required this.token,

    // this.followers = const [],
    this.following = const [],
    this.posts = const [],
    this.interests = const [],
  });
  @override
  List<Object?> get props => [
        id,
        email,
        hasPremium,
        fullName,
        userName,
        dob, lastSeen,
        phoneNumber,
        occupation,
        viewedSetupIndex, visitedUserCount,
        about, token,
        profilePic, notificationPreferences,
        location,
        latitude, visitedUserCount,
        longitude, onlineStatus,
        // ...followers,
        // ...following,
        ...interests,
        ...posts,
      ];
}
