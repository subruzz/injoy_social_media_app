
class UpdatePostEntity {
  final List<String> hashtags;
  // final double? latitude;
  // final double? longitude;
  // final String? location;
  final String? description;

  UpdatePostEntity({
    required this.hashtags,

    this.description,
  });
}
