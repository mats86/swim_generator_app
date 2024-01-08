
class Course {
  final int id;
  final int swimLevelId;
  final String name;
  final double minAge;
  final double maxAge;
  final String price;
  final String description;
  final int hasFixedDates;
  final String duration;
  final int isCourseVisible;

  const Course({
    required this.id,
    required this.swimLevelId,
    required this.name,
    required this.minAge,
    required this.maxAge,
    required this.price,
    required this.description,
    required this.hasFixedDates,
    required this.duration,
    required this.isCourseVisible});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['courseID'],
        swimLevelId: json['swim_level_id'],
        name: json['courseName'],
        minAge: json['courseMinimumAge'].toDouble(),
        maxAge: json['courseMaximumAge'].toDouble(),
        price: json['coursePrice'],
        description: json['courseDescription'],
        hasFixedDates: json['courseHasFixedDates'],
        duration: json['courseDuration'],
        isCourseVisible: json['isCourseVisible']);
  }

  const Course.empty()
      : id = 0,
        swimLevelId = 0,
        name = '',
        minAge = 0,
        maxAge = 0,
        price = '',
        description = '',
        hasFixedDates = 0,
        duration = '',
        isCourseVisible = 0;
}
