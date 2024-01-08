class GraphQLQueries {
  static const String getSwimCourseById = '''
  query getSwimCourseBySwimLevelId(\$id: Int!) {
    swimCourseById(id: \$id) {
      id
      name
      minAge
      maxAge
      price
      description
      hasFixedDates
      duration
      isVisible
      swimLevelId
    }
  }
''';

  static const String getSwimCoursesByLevelAndFutureAge = '''
  query getSwimCoursesByLevelAndFutureAge(\$swimLevelId: Int!, \$birthdate: DateTime!, \$futureDate: DateTime!) {
    swimCoursesByLevelAndFutureAge(swimLevelId: \$swimLevelId, birthdate: \$birthdate, futureDate: \$futureDate) {
      id
      name
      minAge
      maxAge
      price
      description
      hasFixedDates
      duration
      isVisible
      swimLevelId
    }
  }
''';

  static const String getSwimCoursesByLevelNameAndFutureAge = '''
  query getSwimCoursesByLevelNameAndFutureAge(\$swimLevelName: String!, \$birthdate: DateTime!, \$futureDate: DateTime!) {
    swimCoursesByLevelNameAndFutureAge(swimLevelName: \$swimLevelName, birthdate: \$birthdate, futureDate: \$futureDate) {
      id
      name
      minAge
      maxAge
      price
      description
      hasFixedDates
      duration
      isVisible
      swimLevelId
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

}
