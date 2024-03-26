import 'dart:io';
import 'package:stocks_tracking_app/entities/current_request_status.dart';
import 'package:stocks_tracking_app/entities/user_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stocks_tracking_app/models/user_data_model.dart';

class DoLoginRequest {
  Future<(UserData, CurrentRequestStatus)> doLogin(
      String email, String password) async {
    final response = await http.post(
        Uri.parse("https://stock-server-theta.vercel.app/api/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    print(response.statusCode);
    print(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        UserDataModel user = UserDataModel.fromJson(jsonDecode(response.body));
        return (
          user.toUserDataEntity(email, true),
          CurrentRequestStatus('OK', response.statusCode)
        );
      case HttpStatus.badRequest || HttpStatus.unauthorized:
        UserDataModel user =
            UserDataModel.fromJsonError(jsonDecode(response.body));
        return (
          user.toUserDataEntity(email, false),
          CurrentRequestStatus(
              (jsonDecode(response.body) as Map<String, dynamic>)['error'],
              response.statusCode)
        );
      default:
        UserDataModel user =
            UserDataModel.fromJsonError(jsonDecode(response.body));
        return (
          user.toUserDataEntity(email, false),
          CurrentRequestStatus(response.body, response.statusCode)
        );
    }
  }
}
