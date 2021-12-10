import 'package:equatable/equatable.dart';
import 'package:neostore/bloc/form_status.dart';

class LoginState {
  String? username;
  String? password;
  String? id;
  FormStatus? formStatus;

  LoginState(
      {this.username = '',
      this.password = '',
      this.id = '',
      this.formStatus = const InitialFormStatus()});

  LoginState copyWith(
      {String? username,
      String? password,
      FormStatus? formStatus,
      String? id}) {
    return LoginState(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}

class ForgotPassState {
  const ForgotPassState();
}
