class UserProfile {
  String fullName;
  String userName;
  String dob;
  int? phoneNumber;
  String? occupation;
  String? about;
  String? profilePic;
  String? location;
  double? latitude;
  double? longitude;
  List<String>? interests;
  UserProfile({
    required this.fullName,
    required this.userName,
    required this.dob,
    this.phoneNumber,
    this.occupation,
    this.about,
    this.profilePic,
    this.location,
    this.latitude,
    this.interests,
    this.longitude,
  });
}
