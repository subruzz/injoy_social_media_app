import 'package:equatable/equatable.dart';

class PartialUser extends Equatable {
  final String id;
  final String? userName;
  final String? fullName;
  final String? profilePic;
   int followersCount;
   PartialUser({
    required this.id,
    this.userName,
    this.fullName,
    required this.followersCount,
    this.profilePic,
  });

  @override
  List<Object?> get props => [id, userName, fullName, profilePic];

  factory PartialUser.fromJson(Map<String, dynamic> json) {
    return PartialUser(
      id: json['id'],
      followersCount: json['followersCount'],
      userName: json['userName'],
      fullName: json['fullName'],
      profilePic: json['profilePic'],
    );
  }
}
