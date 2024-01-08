class SwimCourse {
  final int id;
  final String name;
  final double minAge;
  final double maxAge;
  final double price;
  final String description;
  final int hasFixedDates;
  final String duration;
  final int isVisible;
  final int swimLevelId;

  SwimCourse({
    required this.id,
    required this.name,
    required this.minAge,
    required this.maxAge,
    required this.price,
    required this.description,
    required this.hasFixedDates,
    required this.duration,
    required this.isVisible,
    required this.swimLevelId,
  });

  factory SwimCourse.fromJson(Map<String, dynamic> json) {
    return SwimCourse(
      id: json['id'],
      name: json['name'],
      minAge: json['minAge'],
      maxAge: json['maxAge'],
      price: json['price'].toDouble(),
      description: json['description'],
      hasFixedDates: json['hasFixedDates'],
      duration: json['duration'],
      isVisible: json['isVisible'],
      swimLevelId: json['swimLevelId'],
    );
  }

  const SwimCourse.empty()
      : id = 0,
        name = '',
        minAge = 0,
        maxAge = 0,
        price = 0,
        description = '',
        hasFixedDates = 1,
        duration = '',
        isVisible = 0,
        swimLevelId = 0;
}
