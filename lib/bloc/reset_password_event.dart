abstract class ResetPasswordEvent {}

class passwordChanged extends ResetPasswordEvent {
  String? password;
  passwordChanged({this.password});
}

class setNewPassword extends ResetPasswordEvent {
  String? newPassword;
  setNewPassword({this.newPassword});
}

class confirmNewPassword extends ResetPasswordEvent {
  String? confirmPassword;
  confirmNewPassword({this.confirmPassword});
}

class resetPassword extends ResetPasswordEvent {
  String? token;
  String? password;
  String? newPassword;
  String? confirmPassword;

  resetPassword(
      {this.token, this.password, this.newPassword, this.confirmPassword});
}
