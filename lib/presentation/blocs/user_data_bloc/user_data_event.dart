part of 'user_data_bloc.dart';

sealed class UserDataEvent {
  const UserDataEvent();
}

class DoLogin extends UserDataEvent {
  final String email;
  final String password;

  DoLogin({required this.email, required this.password});
}

class GetPortfolio extends UserDataEvent {}

class GetSymbolInfo extends UserDataEvent {
  final String symbol;

  GetSymbolInfo({required this.symbol});
}
