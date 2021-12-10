import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/model/account_details.dart';
import 'package:neostore/model/user.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class fetchAccountDetails extends AccountEvent {
  String? token;
  fetchAccountDetails({this.token});

  @override
  List<Object?> get props => [];
}

class updateAccountDetails extends AccountEvent {
  String? firstName;
  String? lastName;
  String? email;
  String? phone_no;
  String? dob;
  String? profile_pic;
  String? token;
  AccountDetails? accountInfo;

  updateAccountDetails(
      {this.firstName,
      this.lastName,
      this.email,
      this.phone_no,
      this.dob,
      this.profile_pic,
      this.token,
      this.accountInfo});

  @override
  List<Object?> get props => [accountInfo];
}
