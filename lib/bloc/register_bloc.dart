import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neostore/bloc/login_event.dart';
import 'package:neostore/bloc/register_event.dart';

import 'package:neostore/bloc/register_state.dart';
import 'package:neostore/bloc/form_status.dart';

import 'package:neostore/model/user.dart';
import 'package:neostore/repository/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository authRepo;
  RegisterBloc({required this.authRepo}) : super(RegisterState());
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is FirstNameChanged) {
      yield state.copyWith(firstname: event.firstname);
    } else if (event is LastNameChanged) {
      yield state.copyWith(lastname: event.lastname);
    } else if (event is EmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is PasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield state.copyWith(confirmPassword: event.confirmPassword);
    } else if (event is GenderChanged) {
      yield state.copyWith(genderr: event.genderr);
    } else if (event is PhoneNumberChanged) {
      yield state.copyWith(phNumber: event.phNumber);
    } else if (event is RegistrationFormSubmitted) {
      yield state.copyWith(
          formStatus: FormSubmitting(),
          firstname: event.firstname,
          lastname: event.lastname,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
          genderr: event.genderr,
          phNumber: event.phNumber);

      try {
        User? user = await authRepo.PostRegistrationData(
            event.firstname,
            event.lastname,
            event.email,
            event.password,
            event.confirmPassword,
            event.genderr,
            event.phNumber);
        if (user!.status == 200) {
         
          yield state.copyWith(formStatus: SubmissionSuccess());
        }
      } on Exception catch (e) {
      

        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
