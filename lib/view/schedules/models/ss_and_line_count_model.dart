class ScheduleData {
  final String dayNumber;
  final String dayName;
  final String substations;
  final String lines;
  final String dtr;
  final bool highlightLines;
  final bool highlightDtr;
  final bool highlightSs;

  const ScheduleData({
    required this.dayNumber,
    required this.dayName,
    required this.substations,
    required this.lines,
    required this.dtr,
    this.highlightLines = false,
    this.highlightDtr = false,
    this.highlightSs = false,
  });
}
class DataModel {
  final String date; // e.g., "19/01/2025"
  final String ss;   // Substations
  final String dtr;  // Distribution Transformer Ratio
  final String line; // Lines

  DataModel({
    required this.date,
    required this.ss,
    required this.dtr,
    required this.line,
  });

  factory DataModel.fromJson(MapEntry<String, dynamic> entry) {
    final date = entry.key;
    final data = entry.value as Map<String, dynamic>;
    return DataModel(
      date: date,
      ss: data['ss'] ?? '',
      dtr: data['dtr'] ?? '',
      line: data['line'] ?? '',
    );
  }

  /// Convert to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {'date': date, 'ss': ss, 'dtr': dtr, 'line': line};
  }

  @override
  String toString() {
    return 'DataModel(date: $date, ss: $ss, dtr: $dtr, line: $line)';
  }
}