import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';

class SearchLocationModel extends ExploreLocationSearchEntity {

  SearchLocationModel({
    required super.latitude,
    required super.longitude,
    required super.locationName,
    required super.count,
  });

  factory SearchLocationModel.fromJson(Map<String, dynamic> json) {
    return SearchLocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      locationName: json['locationName'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
      'count': count,
    };
  }
}
