class SwimCourse {
  final int swimCourseID;
  final String swimCourseName;
  final double swimCourseMinAge;
  final double swimCourseMaxAge;
  final double swimCoursePrice;
  final String swimCourseDescription;
  final int swimCourseDateTypID;
  final String swimCourseDuration;
  final bool isSwimCourseVisible;
  final int swimLevelID;

  SwimCourse({
    required this.swimCourseID,
    required this.swimCourseName,
    required this.swimCourseMinAge,
    required this.swimCourseMaxAge,
    required this.swimCoursePrice,
    required this.swimCourseDescription,
    required this.swimCourseDateTypID,
    required this.swimCourseDuration,
    required this.isSwimCourseVisible,
    required this.swimLevelID,
  });

  factory SwimCourse.fromJson(Map<String, dynamic> json) {
    return SwimCourse(
      swimCourseID: json['swimCourseID'],
      swimCourseName: json['swimCourseName'],
      swimCourseMinAge: json['swimCourseMinAge'],
      swimCourseMaxAge: json['swimCourseMaxAge'],
      swimCoursePrice: json['swimCoursePrice'].toDouble(),
      swimCourseDescription: json['swimCourseDescription'],
      swimCourseDateTypID: json['swimCourseDateTypID'],
      swimCourseDuration: json['swimCourseDuration'],
      isSwimCourseVisible: json['isSwimCourseVisible'],
      swimLevelID: json['swimLevelID'],
    );
  }

  const SwimCourse.empty()
      : swimCourseID = 0,
        swimCourseName = '',
        swimCourseMinAge = 0,
        swimCourseMaxAge = 0,
        swimCoursePrice = 0,
        swimCourseDescription = '',
        swimCourseDateTypID = 0,
        swimCourseDuration = '',
        isSwimCourseVisible = false,
        swimLevelID = 0;
}
