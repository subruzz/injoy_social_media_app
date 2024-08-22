class UpdatePostEntity {
  final List<String> hashtags;
  // final double? latitude;
  // final double? longitude;
  // final String? location;
  final List<String> oldPostHashtags;
  final String? description;
  UpdatePostEntity({
    required this.hashtags,
    required this.oldPostHashtags,
    this.description,
  });
  Map<String, dynamic> toJson() {
    return {
      'isEdited': true,
      'hashtags': hashtags,
      'description': description,
    };
  }
}
