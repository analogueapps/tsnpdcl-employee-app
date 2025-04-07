// substation.dart
class Substation {
  final String id;
  final String name;

  Substation({required this.id, required this.name});

  factory Substation.fromJson(Map<String, dynamic> json) {
    return Substation(
      id: json['circleCode'] as String,
      name: json['sectionCode'] as String,
    );
  }
}

// interruption_details.dart (example, adjust based on your API response)
class InterruptionDetails {
  final String type;
  final int noOfInterruptions;
  final int durationInMinutes;

  InterruptionDetails({
    required this.type,
    required this.noOfInterruptions,
    required this.durationInMinutes,
  });

  factory InterruptionDetails.fromJson(Map<String, dynamic> json) {
    return InterruptionDetails(
      type: json['type'] as String,
      noOfInterruptions: json['noOfInterruptions'] as int,
      durationInMinutes: json['durationInMinutes'] as int,
    );
  }
}