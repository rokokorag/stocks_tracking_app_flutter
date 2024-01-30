import 'package:flutter/material.dart';
import 'package:stocks_tracking_app/entities/current_request_status.dart';
import 'package:stocks_tracking_app/entities/user_data.dart';
import 'package:stocks_tracking_app/helpers/do_login.dart';

class StateProvider extends ChangeNotifier {
  final DoLoginRequest doLoginRequest = DoLoginRequest();
  UserData userData = UserData(email: '', token: '', isLogin: false);
  CurrentRequestStatus currentRequestStatus = CurrentRequestStatus('', 0);

  Future<void> doLogin(String email, String password) async {
    final (user, requestStatus) = await doLoginRequest.doLogin(email, password);
    userData = user;
    currentRequestStatus = requestStatus;
    notifyListeners();
  }
}
