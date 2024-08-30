import 'package:equatable/equatable.dart';

class PartialUser extends Equatable {
  final String id;
  final String? userName;
  final String? fullName;
  final String? profilePic;

  const PartialUser({
    required this.id,
    this.userName,
    this.fullName,
    this.profilePic,
  });

  @override
  List<Object?> get props => [id, userName, fullName, profilePic];

  factory PartialUser.fromJson(Map<String, dynamic> json) {
    return PartialUser(
      id: json['id'],
      userName: json['userName'],
      fullName: json['fullName'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'fullName': fullName,
      'profilePic': profilePic,
    };
  }
}
