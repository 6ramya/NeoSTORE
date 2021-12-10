import 'package:equatable/equatable.dart';

import 'package:neostore/model/account_details.dart';
import 'package:neostore/model/user.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitialState extends AccountState {
  const AccountInitialState();
  @override
  List<Object> get props => [];
}

class AccountDetailsLoadingState extends AccountState {
  const AccountDetailsLoadingState();
  @override
  List<Object> get props => [];
}

class AccountDetailsLoadedState extends AccountState {
  AccountDetails? user;
  AccountDetailsLoadedState({this.user});

  @override
  List<Object> get props => [user!];
}

class UpdateAccountState extends AccountState {
  AccountDetails? details;
  UpdateAccountState({this.details});
  @override
  List<Object> get props => [details!];
}

class AccountDetailsUpdated extends AccountState {
  AccountDetails? updatedDetails;
  AccountDetailsUpdated({this.updatedDetails});

  @override
  List<Object?> get props => [updatedDetails];
}

class AccountDetailsLoadFailed extends AccountState {
  String? error;
  AccountDetailsLoadFailed({this.error});

  @override
  List<Object?> get props => [];
}

class UpdateDeatilsFailed extends AccountState {
  String? error;
  UpdateDeatilsFailed({this.error});

  @override
  List<Object?> get props => [];
}
