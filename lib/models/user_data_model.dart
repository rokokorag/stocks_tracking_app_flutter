import 'package:stocks_tracking_app/entities/user_data.dart';

class UserDataModel {
  final String token;

  UserDataModel({required this.token});

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      UserDataModel(token: json['session-token']);

  factory UserDataModel.fromJsonError(Map<String, dynamic> json) =>
      UserDataModel(token: json['error']);

  UserData toUserDataEntity(String email, bool isLogin) =>
      UserData(email: email, token: token, isLogin: isLogin);
}
