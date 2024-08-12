enum PremiumSubType {
  oneMonth,
  threeMonth,
  oneYear;

  String toJson() => name;
  static PremiumSubType fromJson(String json) {
    return values.byName(json);
  }
}