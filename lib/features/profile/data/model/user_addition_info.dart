class UserAdditionInfo {
  final double? latitude;
  final double? longitude;
  final String? currentLocationName;
  final List<String> interests;

  UserAdditionInfo({
    required this.latitude,
    required this.longitude,
    required this.currentLocationName,
    required this.interests,
  });

  factory UserAdditionInfo.fromJson(Map<String, dynamic> json) {
    return UserAdditionInfo(
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      currentLocationName: json['location'] as String?,
      interests: List<String>.from(json['interests'] as List),
    );
  }

  Map<String, dynamic> toJson(int index) {
    return {
      'viewedSetupIndex': index,
      'latitude': latitude,
      'longitude': longitude,
      'location': currentLocationName,
      'interests': interests,
    };
  }

  bool isComplete() {
    return latitude != null &&
        longitude != null &&
        currentLocationName != null &&
        interests.isNotEmpty;
  }
}
