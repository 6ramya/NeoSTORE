import 'package:neostore/bloc/form_status.dart';

abstract class RegisterEvent {}

class FirstNameChanged extends RegisterEvent {
  final String? firstname;
  FirstNameChanged({this.firstname});
}

class LastNameChanged extends RegisterEvent {
  final String? lastname;
  LastNameChanged({this.lastname});
}

class EmailChanged extends RegisterEvent {
  final String? email;
  EmailChanged({this.email});
}

class PasswordChanged extends RegisterEvent {
  final String? password;
  PasswordChanged({this.password});
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String? confirmPassword;
  ConfirmPasswordChanged({this.confirmPassword});
}

class GenderChanged extends RegisterEvent {
  final String? genderr;
  GenderChanged({this.genderr});
}

class PhoneNumberChanged extends RegisterEvent {
  final String? phNumber;
  PhoneNumberChanged({this.phNumber});
}

class RegistrationFormSubmitted extends RegisterEvent {
  FormStatus? formStatus;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? confirmPassword;
  String? genderr;
  String? phNumber;
  RegistrationFormSubmitted(
      {this.formStatus,
      this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.confirmPassword,
      this.genderr,
      this.phNumber});
}
