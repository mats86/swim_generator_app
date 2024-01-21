class FixDate {
  final int fixDateID;
  final int swimPoolID;
  final int swimCourseID;
  final DateTime? fixDateFrom;
  final DateTime? fixDateTo;
  final bool isFixDateActive;

  FixDate({
    required this.fixDateID,
    required this.swimPoolID,
    required this.swimCourseID,
    required this.fixDateFrom,
    required this.fixDateTo,
    required this.isFixDateActive,
  });

  factory FixDate.fromJson(Map<String, dynamic> json) {
    return FixDate(
      fixDateID: json['fixDateID'] ?? 0,
      swimPoolID: json['swimPoolID'] ?? 0,
      swimCourseID: json['swimCourseID'] ?? 0,
      fixDateFrom: DateTime.tryParse(json['fixDateFrom']) ?? DateTime(1970),
      fixDateTo: DateTime.tryParse(json['fixDateTo']) ?? DateTime(1970),
      isFixDateActive: json['isFixDateActive'] ?? false,
    );
  }

  const FixDate.empty()
      : fixDateID = 0,
        swimPoolID = 0,
        swimCourseID = 0,
        fixDateFrom = null,
        fixDateTo = null,
        isFixDateActive = false;
}
