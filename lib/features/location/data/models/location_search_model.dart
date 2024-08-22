class PhotonResponse {
  final List<SuggestedLocation> features;

  PhotonResponse({required this.features});

  factory PhotonResponse.fromJson(Map<String, dynamic> json) {
    return PhotonResponse(
      features: (json['features'] as List)
          .map((item) => SuggestedLocation.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'features': features.map((feature) => feature.toJson()).toList(),
    };
  }
}

class SuggestedLocation {
  final Geometry geometry;
  final Properties properties;
  double get latitude => geometry.coordinates[1];
  double get longitude => geometry.coordinates[0];
  SuggestedLocation({required this.geometry, required this.properties});

  factory SuggestedLocation.fromJson(Map<String, dynamic> json) {
    return SuggestedLocation(
      geometry: Geometry.fromJson(json['geometry']),
      properties: Properties.fromJson(json['properties']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geometry': geometry.toJson(),
      'properties': properties.toJson(),
    };
  }
}

class Geometry {
  final List<double> coordinates;
  final String type;

  Geometry({required this.coordinates, required this.type});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      coordinates: (json['coordinates'] as List)
          .map((coord) => (coord as num)
              .toDouble()) // Convert num (int or double) to double
          .toList(),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates,
      'type': type,
    };
  }
}

class Properties {
  final String osmType;
  final List<double>? extent;
  final String? country;
  final String osmKey;
  final String countryCode;
  final String osmValue;
  final String? name;
  final String? type;
  final String? state;
  final String? city;
  final String? postcode;
  final String? county;

  Properties({
    required this.osmType,
    this.extent,
    this.country,
    required this.osmKey,
    required this.countryCode,
    required this.osmValue,
    this.name,
    this.type,
    this.state,
    this.city,
    this.postcode,
    this.county,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      osmType: json['osm_type'],
      extent: json['extent'] != null
          ? (json['extent'] as List).map((e) => (e as num).toDouble()).toList()
          : null,
      country: json['country'],
      osmKey: json['osm_key'],
      countryCode: json['countrycode'],
      osmValue: json['osm_value'],
      name: json['name'],
      type: json['type'],
      state: json['state'],
      city: json['city'],
      postcode: json['postcode'],
      county: json['county'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'osm_type': osmType,
      'extent': extent,
      'country': country,
      'osm_key': osmKey,
      'countrycode': countryCode,
      'osm_value': osmValue,
      'name': name,
      'type': type,
      'state': state,
      'city': city,
      'postcode': postcode,
      'county': county,
    };
  }
}
