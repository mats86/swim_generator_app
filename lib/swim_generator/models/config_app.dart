import 'package:equatable/equatable.dart';

class ConfigApp extends Equatable {
  final bool isEmailExists;
  final bool isDirectLinks;
  final bool isBooking;
  final bool isStartFixDate;

  const ConfigApp({
    required this.isEmailExists,
    required this.isDirectLinks,
    required this.isBooking,
    required this.isStartFixDate,
  });

  const ConfigApp.empty()
      : this(
          isEmailExists: false,
          isDirectLinks: false,
          isBooking: false,
          isStartFixDate: false,
        );

  ConfigApp copyWith({
    bool? isEmailExists,
    bool? isDirectLinks,
    bool? isBooking,
    bool? isStartFixDate,
  }) {
    return ConfigApp(
        isEmailExists: isEmailExists ?? this.isEmailExists,
        isDirectLinks: isDirectLinks ?? this.isDirectLinks,
        isBooking: isBooking ?? this.isBooking,
        isStartFixDate: isStartFixDate ?? this.isStartFixDate);
  }

  @override
  List<Object> get props => [
        isEmailExists,
        isDirectLinks,
        isBooking,
        isStartFixDate,
      ];
}
