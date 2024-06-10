class AppUser {
  final String id;
  final String email;
  final bool hasPremium;

  String? fullName;
  String? userName;
  String? dob;
  int? phoneNumber;
  String? occupation;
  String? about;
  String? profilePic;
  String? location;
  double? latitude;
  double? longitude;

  AppUser({
    required this.id,
    required this.email,
    required this.hasPremium,
    this.fullName,
    this.userName,
    this.dob,
    this.phoneNumber,
    this.occupation,
    this.about,
    this.profilePic,
    this.location,
    this.latitude,
    this.longitude,
  });
}
