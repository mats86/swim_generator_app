import 'package:equatable/equatable.dart';

class KindPersonalInfo extends Equatable {
  final String firstName;
  final String lastName;

  const KindPersonalInfo({this.firstName = '', this.lastName = ''});

  KindPersonalInfo copyWith({
    String? firstName,
    String? lastName,
  }) {
    return KindPersonalInfo(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
      ];
}
