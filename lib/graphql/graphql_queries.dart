class GraphQLQueries {
  static const String getSwimCourseById = '''
  query getSwimCourseById(\$swimCourseID: Int!) {
    swimCourseById(swimCourseID: \$swimCourseID) {
      swimCourseID
      swimCourseName
      swimCourseMinAge
      swimCourseMaxAge
      swimCoursePrice
      swimCourseDescription
      swimCourseDateTypID
      swimCourseDuration
      isSwimCourseVisible
      swimLevelID
    }
  }
''';

  static const String getSwimCoursesByLevelAndFutureAge = '''
  query getSwimCoursesByLevelAndFutureAge(\$swimLevelID: Int!, \$birthdate: DateTime!, \$futureDate: DateTime!) {
    swimCoursesByLevelAndFutureAge(swimLevelID: \$swimLevelID, birthdate: \$birthdate, futureDate: \$futureDate) {
      swimCourseID
      swimCourseName
      swimCourseMinAge
      swimCourseMaxAge
      swimCoursePrice
      swimCourseDescription
      swimCourseDateTypID
      swimCourseDuration
      isSwimCourseVisible
      swimLevelID
    }
  }
''';

  static const String getSwimCoursesByLevelNameAndFutureAge = '''
  query getSwimCoursesByLevelNameAndFutureAge(\$swimLevelName: String!, \$birthdate: DateTime!, \$futureDate: DateTime!) {
    swimCoursesByLevelNameAndFutureAge(swimLevelName: \$swimLevelName, birthdate: \$birthdate, futureDate: \$futureDate) {
      swimCourseID
      swimCourseName
      swimCourseMinAge
      swimCourseMaxAge
      swimCoursePrice
      swimCourseDescription
      swimCourseDateTypID
      swimCourseDuration
      isSwimCourseVisible
      swimLevelID
    }
  }
''';

  static const String getSwimPools = '''
  query getSwimPools {
    swimPools {
      swimPoolID
      swimPoolName
      swimPoolAddress
      swimPoolPhoneNumber
      swimPoolOpeningTimes {
        day
        openTime
        closeTime
      }
      swimPoolHasFixedDate
      isSwimPoolVisible
    }
  }
''';

  static const String createCompleteSwimCourseBooking = '''
  mutation createCompleteSwimCourseBooking(\$input: CompleteSwimCourseBookingInput!) {
    createCompleteSwimCourseBooking(input: \$input) {
      swimCourseBookingID
      swimCourseID
      studentID
      guardianID
    }
  }
''';

  static const String getFixDates = '''
    query getFixDates {
      fixDates {
        fixDateID
        swimCourseID
        swimPoolID
        fixDateFrom
        fixDateTo
        isFixDateActive
      }
    }
  ''';

  static const String getFixDatesBySwimCourseID = '''
    query getFixDatesBySwimCourseID(\$swimCourseID: Int!) {
      fixDatesBySwimCourseID(swimCourseID: \$swimCourseID) {
        fixDateID
        swimCourseID
        swimPoolID
        fixDateFrom
        fixDateTo
        isFixDateActive
      }
    }
  ''';

  static const String getFixDatesBySwimPoolID = '''
    query getFixDatesBySwimPoolID(\$swimPoolID: Int!) {
      fixDatesBySwimPoolID(swimPoolID: \$swimPoolID) {
        fixDateID
        swimCourseID
        swimPoolID
        fixDateFrom
        fixDateTo
        isFixDateActive
      }
    }
  ''';

  static const String getFixDatesBySwimCourseIDAndSwimPoolID = '''
    query getFixDatesBySwimCourseIDAndSwimPoolID(\$swimCourseID: Int!, \$swimPoolID: Int!) {
      fixDatesBySwimCourseIDAndSwimPoolID(swimCourseID: \$swimCourseID, swimPoolID: \$swimPoolID) {
        fixDateID
        swimCourseID
        swimPoolID
        fixDateFrom
        fixDateTo
        isFixDateActive
      }
    }
  ''';

}
