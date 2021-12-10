import 'package:neostore/bloc/form_status.dart';
import 'package:neostore/pages/register.dart';

class RegisterState {
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? confirmPassword;
  String? genderr;
  String? phoneNumber;
  FormStatus? formStatus;

  RegisterState(
      {this.firstname = '',
      this.lastname = '',
      this.email = '',
      this.password = '',
      this.confirmPassword = '',
      this.genderr = '',
      this.phoneNumber = '',
      this.formStatus = const InitialFormStatus()});

  RegisterState copyWith(
      {String? firstname,
      String? lastname,
      String? password,
      String? confirmPassword,
      String? email,
      String? genderr,
      String? phoneNumber,
      FormStatus? formStatus,
      String? phNumber}) {
    return RegisterState(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        email: email ?? this.email,
        genderr: genderr ?? this.genderr,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        formStatus: formStatus ?? this.formStatus);
  }
}
