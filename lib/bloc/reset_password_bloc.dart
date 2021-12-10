import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neostore/bloc/register_event.dart';
import 'package:neostore/bloc/reset_password_event.dart';
import 'package:neostore/bloc/reset_password_state.dart';
import 'package:neostore/repository/user_repository.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, resetPasswordState> {
  UserRepository? authRepo;
  ResetPasswordBloc({this.authRepo}) : super(resetPasswordState());

  Stream<resetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
    if (event is passwordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is setNewPassword) {
      yield state.copyWith(newPassword: event.newPassword);
    } else if (event is confirmNewPassword) {
      yield state.copyWith(confirmPassword: event.confirmPassword);
    } else if (event is resetPassword) {
      yield state.copyWith(
          password: event.password,
          newPassword: event.newPassword,
          confirmPassword: event.confirmPassword);

      try {
        await authRepo!.resetPassword(
            token: event.token,
            password: event.password,
            newPassword: event.newPassword,
            confirmPassword: event.confirmPassword);
      } on Exception catch (e) {}
    }
  }
}
