import 'package:equatable/equatable.dart';
import 'package:neostore/bloc/form_status.dart';

abstract class LoginEvent {}

class LoginUserNameChanged extends LoginEvent {
  final String? username;
  LoginUserNameChanged({this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String? password;
  LoginPasswordChanged({this.password});
}

class FormSubmitted extends LoginEvent {
  FormStatus? formStatus;
  String? username;
  String? password;
  FormSubmitted({this.formStatus, this.username, this.password});
}

class ForgotPass extends LoginEvent {
  String? email;
  ForgotPass({this.email});
}
