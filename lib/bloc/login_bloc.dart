import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neostore/bloc/login_event.dart';
import 'package:neostore/bloc/login_state.dart';
import 'package:neostore/bloc/form_status.dart';
import 'package:neostore/shared_preference/user_shared_preference.dart';

import 'package:neostore/model/user.dart';
import 'package:neostore/pages/home_screen.dart';
import 'package:neostore/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository authRepo;
  LoginBloc({required this.authRepo}) : super(LoginState());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserNameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is FormSubmitted) {
      yield state.copyWith(
          formStatus: FormSubmitting(),
          username: event.username,
          password: event.password);

      try {
        User? user = await authRepo.PostData(event.username, event.password);
        if (user!.status == 200) {
          // state.id = '{user.data.id}';
          await UserPreferences.setUser(user);
          // print();
          yield state.copyWith(
              formStatus: SubmissionSuccess(), id: '${user.data.id}');
        }
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ForgotPass) {
      try {
        await authRepo.ForgotPasswrd(email: event.email);
      } on Exception catch (e) {}
    }
  }
}
