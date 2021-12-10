class resetPasswordState {
  String? password;
  String? newPassword;
  String? confirmPassword;

  resetPasswordState(
      {this.password = '', this.newPassword = '', this.confirmPassword = ''});

  resetPasswordState copyWith(
      {String? password, String? newPassword, String? confirmPassword}) {
    return resetPasswordState(
        password: password ?? this.password,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword);
  }
}
