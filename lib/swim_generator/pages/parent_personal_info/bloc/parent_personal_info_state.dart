
part of 'parent_personal_info_bloc.dart';

class ParentPersonalInfoState extends Equatable {
  const ParentPersonalInfoState({
    this.titleList = const [],
    this.title = const TitleModel.pure(),
    this.firstName = const FirstNameModel.pure(),
    this.lastName = const LastNameModel.pure(),
    this.street = const StreetModel.pure(),
    this.streetNumber = const StreetNumberModel.pure(),
    this.zipCode = const ZipCodeModel.pure(),
    this.city = const CityModel.pure(),
    this.email = const EmailModel.pure(),
    this.emailConfirm = const EmailConfirmModel.pure(),
    this.phoneNumber = const PhoneNumberModel.pure(),
    this.phoneNumberConfirm = const PhoneNumberConfirmModel.pure(),
    this.isValid = false,
    this.loadingTitleStatus = FormzSubmissionStatus.initial,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final List<String> titleList;
  final TitleModel title;
  final FirstNameModel firstName;
  final LastNameModel lastName;
  final StreetModel street;
  final StreetNumberModel streetNumber;
  final ZipCodeModel zipCode;
  final CityModel city;
  final EmailModel email;
  final EmailConfirmModel emailConfirm;
  final PhoneNumberModel phoneNumber;
  final PhoneNumberConfirmModel phoneNumberConfirm;
  final bool isValid;
  final FormzSubmissionStatus loadingTitleStatus;
  final FormzSubmissionStatus submissionStatus;

  ParentPersonalInfoState copyWith({
    List<String>? titleList,
    TitleModel? title,
    FirstNameModel? firstName,
    LastNameModel? lastName,
    StreetModel? street,
    StreetNumberModel? streetNumber,
    ZipCodeModel? zipCode,
    CityModel? city,
    EmailModel? email,
    EmailConfirmModel? emailConfirm,
    PhoneNumberModel? phoneNumber,
    PhoneNumberConfirmModel? phoneNumberConfirm,
    bool? isValid,
    FormzSubmissionStatus? loadingTitleStatus,
    FormzSubmissionStatus? submissionStatus}) {
    return ParentPersonalInfoState(
        titleList: titleList ?? this.titleList,
        title: title ?? this.title,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        street: street ?? this.street,
        streetNumber: streetNumber ?? this.streetNumber,
        zipCode: zipCode ?? this.zipCode,
        city: city ?? this.city,
        email: email ?? this.email,
        emailConfirm: emailConfirm ?? this.emailConfirm,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneNumberConfirm: phoneNumberConfirm ?? this.phoneNumberConfirm,
        isValid: isValid ?? this.isValid,
        loadingTitleStatus: loadingTitleStatus ?? this.loadingTitleStatus,
        submissionStatus: submissionStatus ?? this.submissionStatus);
  }

  @override
  List<Object?> get props =>
      [
        titleList,
        title,
        firstName,
        lastName,
        street,
        streetNumber,
        zipCode,
        city,
        email,
        emailConfirm,
        phoneNumber,
        phoneNumberConfirm,
        loadingTitleStatus,
        submissionStatus,
      ];
}
