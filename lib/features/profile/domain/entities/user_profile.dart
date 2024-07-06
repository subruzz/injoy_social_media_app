class UserProfile {
  String fullName;
  String userName;
  String dob;
  String? phoneNumber;
  String? occupation;
  String? about;
  String? profilePic;
  String? location;
  double? latitude;
  double? longitude;
  List<String> interests;

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
    this.interests = const [],
    this.longitude,
  });

  @override
  String toString() {
    return 'UserProfile(fullName: $fullName, userName: $userName, dob: $dob, phoneNumber: $phoneNumber, occupation: $occupation, about: $about, profilePic: $profilePic, location: $location, latitude: $latitude, longitude: $longitude, interests: $interests)';
  }
}
