class WaterPerDay {
  final double waterConsumption;
  final String timeCreated;
  final String measureUnit;

  WaterPerDay({required this.waterConsumption, required this.measureUnit, required this.timeCreated});

  Map<String, dynamic> toJson() {
    return {
      'waterConsumption': waterConsumption,
      'measureUnit': measureUnit,
      'timeCreated': timeCreated,
    };
  }
}
