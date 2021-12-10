import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neostore/bloc/account_event.dart';
import 'package:neostore/bloc/account_state.dart';

import 'package:neostore/model/account_details.dart';
import 'package:neostore/model/user.dart';
import 'package:neostore/repository/user_repository.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  UserRepository? authRepo;
  AccountBloc({this.authRepo}) : super(AccountInitialState());

  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is fetchAccountDetails) {
      yield AccountDetailsLoadingState();
      try {
        AccountDetails? accountDetails =
            await authRepo!.getAccountDetails(accessToken: event.token);
      
        if (accountDetails!.status == 200) {
          yield AccountDetailsLoadedState(user: accountDetails);
  
        }
      } on Exception catch (e) {
        yield AccountDetailsLoadFailed(error: e.toString());
      }
    } else if (event is updateAccountDetails) {
     
      try {
        AccountDetails? user = await authRepo!.UpdateAccountInfo(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          phoneNo: event.phone_no,
          dob: event.dob,
          profile_pic: event.profile_pic,
          accessToken: event.token,
          accountInfo: event.accountInfo,
        );
     

        yield AccountDetailsUpdated(updatedDetails: user);
       
      } on Exception catch (e) {
        yield UpdateDeatilsFailed(error: e.toString());
      }
    }
  }
}
