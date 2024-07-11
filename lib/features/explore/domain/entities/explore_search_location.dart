class ExploreLocationSearchEntity {
  final double? latitude;
  final double? longitude;
  final String locationName;
  final int count;

  ExploreLocationSearchEntity(
      {required this.latitude,
      required this.longitude,
      required this.locationName,
      required this.count});
}
