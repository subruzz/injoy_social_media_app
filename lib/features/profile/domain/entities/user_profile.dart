class UserProfile {
  String fullName;
  String dob;
  String? phoneNumber;
  String? occupation;
  String? about;
  String? profilePic;
  String? location;
  double? latitude;
  double? longitude;
  List<String> interests;
  final String userName;
  UserProfile({
    required this.fullName,
    required this.dob,
    this.phoneNumber,
    this.occupation,
    required this.userName,
    this.about,
    this.profilePic,
    this.location,
    this.latitude,
    this.interests = const [],
    this.longitude,
  });
}
