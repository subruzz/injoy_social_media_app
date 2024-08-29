import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';

import '../../const/enums/premium_type.dart';

class AppUser extends Equatable {
  final String id;
  final String email;
  bool hasPremium;
  final String? fullName;
  String? userName;
   UserPremium? userPrem;
  final String? dob;
  final String? phoneNumber;
  final String? occupation;
  final String? about;
  final String? profilePic;
  final Timestamp? lastSeen;
  final NotificationPreferences notificationPreferences;
  final int visitedUserCount;
  final String token;

  int followersCount;
  int followingCount;
  final List<String> following;
  final bool onlineStatus;
  final List<String> posts;
  final int viewedSetupIndex;
  bool showLastSeen;
  final List<String> savedPosts;
  AppUser({
    required this.id,
    this.viewedSetupIndex = 0,
    required this.showLastSeen,
    required this.notificationPreferences,
    required this.email,
    required this.savedPosts,
    this.lastSeen,
    required this.hasPremium,
    required this.fullName,
    required this.userName,
    required this.onlineStatus,
    required this.dob,
    required this.followersCount,
    required this.followingCount,
    this.phoneNumber,
    this.userPrem,
    this.occupation,
    this.about,
    this.profilePic,
    required this.visitedUserCount,
    required this.token,
    this.following = const [],
    this.posts = const [],
  });

  @override
  List<Object?> get props => [
        id,
        email,
        hasPremium,
        fullName,
        userName,
        dob,
        showLastSeen,
        phoneNumber,
        occupation,
        about,
        profilePic,
        userPrem,
        lastSeen,
        notificationPreferences,
        visitedUserCount,
        token,
        followersCount,
        followingCount,
        onlineStatus,
        viewedSetupIndex,
        ...savedPosts,
        ...following,
        ...posts,
      ];

  AppUser copyWith({
    String? id,
    String? email,
    bool? hasPremium,
    String? fullName,
    String? userName,
    String? dob,
    bool? showLastSeen,
    String? phoneNumber,
    String? occupation,
    String? about,
    String? profilePic,
    String? location,
    Timestamp? lastSeen,
    NotificationPreferences? notificationPreferences,
    int? visitedUserCount,
    String? token,
    double? latitude,
    double? longitude,
    UserPremium? userPrem,
    int? followersCount,
    int? followingCount,
    List<String>? following,
    List<String>? interests,
    bool? onlineStatus,
    List<String>? posts,
    List<String>? savedPosts,
    int? viewedSetupIndex,
  }) {
    return AppUser(
      savedPosts: savedPosts ?? this.savedPosts,
      id: id ?? this.id,
      userPrem: userPrem ?? this.userPrem,
      email: email ?? this.email,
      hasPremium: hasPremium ?? this.hasPremium,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      dob: dob ?? this.dob,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      occupation: occupation ?? this.occupation,
      about: about ?? this.about,
      profilePic: profilePic ?? this.profilePic,
      lastSeen: lastSeen ?? this.lastSeen,
      showLastSeen: showLastSeen ?? this.showLastSeen,
      notificationPreferences:
          notificationPreferences ?? this.notificationPreferences,
      visitedUserCount: visitedUserCount ?? this.visitedUserCount,
      token: token ?? this.token,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      following: following ?? this.following,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      posts: posts ?? this.posts,
      viewedSetupIndex: viewedSetupIndex ?? this.viewedSetupIndex,
    );
  }
}

class UserPremium extends Equatable {
  final PremiumSubType premType;
  final Timestamp purchasedAt;

  const UserPremium({required this.premType, required this.purchasedAt});

  // Convert UserPremium to a Map (JSON-compatible)
  Map<String, dynamic> toJson() {
    return {
      'premType': premType.toJson(),
      'purchasedAt': FieldValue.serverTimestamp(),
    };
  }

  // Create UserPremium from a Map (JSON-compatible)
  factory UserPremium.fromJson(Map<String, dynamic> json) {
    return UserPremium(
      premType: PremiumSubType.fromJson(json['premType'] as String),
      purchasedAt: json['purchasedAt'] as Timestamp,
    );
  }

  @override
  List<Object?> get props => [premType, purchasedAt];
}
