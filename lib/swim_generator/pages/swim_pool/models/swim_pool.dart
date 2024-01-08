class SwimPool {
  final int swimPoolID;
  final String swimPoolName;
  final String swimPoolAddress;
  final String swimPoolPhoneNumber;
  final List<OpenTime> swimPoolOpeningTimes;
  final bool isSelected;

  SwimPool({
    required this.swimPoolID,
    required this.swimPoolName,
    required this.swimPoolAddress,
    required this.swimPoolPhoneNumber,
    required this.swimPoolOpeningTimes,
    required this.isSelected,
  });

  factory SwimPool.fromJson(Map<String, dynamic> json) {
    var openingTimesJson = json['swimPoolOpeningTimes'] as List<dynamic>? ?? [];

    return SwimPool(
      swimPoolID: json['swimPoolID'],
      swimPoolName: json['swimPoolName'],
      swimPoolAddress: json['swimPoolAddress'],
      swimPoolPhoneNumber: json['swimPoolPhoneNumber'],
      swimPoolOpeningTimes:
          openingTimesJson.map((i) => OpenTime.fromJson(i)).toList(),
      isSelected: false,
    );
  }
}

class OpenTime {
  final String day;
  final String openTime;
  final String closeTime;

  OpenTime({
    required this.day,
    required this.openTime,
    required this.closeTime,
  });

  factory OpenTime.fromJson(Map<String, dynamic> json) {
    return OpenTime(
      day: json['day'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
    );
  }
}
