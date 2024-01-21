class CompleteSwimCourseBookingInput {
  final String loginEmail;
  final String guardianFirstName;
  final String guardianLastName;
  final String guardianAddress;
  final String guardianPhoneNumber;
  final String studentFirstName;
  final String studentLastName;
  final DateTime studentBirthDate; // Format: "YYYY-MM-DD"
  final int swimCourseID;
  final List<int> swimPoolIDs;
  final String referenceBooking;
  final int fixDateID;

  CompleteSwimCourseBookingInput({
    required this.loginEmail,
    required this.guardianFirstName,
    required this.guardianLastName,
    required this.guardianAddress,
    required this.guardianPhoneNumber,
    required this.studentFirstName,
    required this.studentLastName,
    required this.studentBirthDate,
    required this.swimCourseID,
    required this.swimPoolIDs,
    required this.referenceBooking,
    required this.fixDateID,
  });

  Map<String, dynamic> toGraphqlJson() {
    return {
      'loginEmail': loginEmail,
      'guardianFirstName': guardianFirstName,
      'guardianLastName': guardianLastName,
      'guardianAddress': guardianAddress,
      'guardianPhoneNumber': guardianPhoneNumber,
      'studentFirstName': studentFirstName,
      'studentLastName': studentLastName,
      'studentBirthDate': studentBirthDate.toIso8601String(),
      'swimCourseID': swimCourseID,
      'swimPoolIDs': swimPoolIDs,
      'referenceBooking': referenceBooking,
      'fixDateID': fixDateID,
    };
  }
}
