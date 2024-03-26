part of 'user_data_bloc.dart';

sealed class UserDataEvent {
  const UserDataEvent();
}

class UserDataAssing extends UserDataEvent {
  String? email;
  String? token;
  bool isLogin = false;

  UserDataAssing({this.email, this.token, this.isLogin = false});
}

class DoLogin extends UserDataEvent {
  final String email;
  final String password;

  DoLogin({required this.email, required this.password});
}

class GetPortfolio extends UserDataEvent {}
