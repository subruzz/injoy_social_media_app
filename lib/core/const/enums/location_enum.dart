enum LocationStatus {
  locationNotEnabled,
  locationPermissionDenied,
  locationPermissionDeniedForever,
  locationPermissionAllowed,
}

enum PremiumSubType {
  oneMonth,
  threeMonth,
  oneYear;

  String toJson() => name;
  static PremiumSubType fromJson(String json) {
    return values.byName(json);
  }
}
