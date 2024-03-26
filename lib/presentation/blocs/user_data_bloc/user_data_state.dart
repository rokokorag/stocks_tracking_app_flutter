part of 'user_data_bloc.dart';

abstract class UserDataState {
  // String? email;
  // String? token;
  // bool isLogin = false;
  // double currentValue = 0;
  // double initialInvestment = 0;
  // List<PositionModel> portfolio = List<PositionModel>.empty();

  // UserDataBlocState();

  // UserDataBlocState copyWith(
  //     {String? email,
  //     String? token,
  //     bool? isLogin,
  //     double? currentValue,
  //     double? initialInvestment,
  //     List<PositionModel>? portfolio}) {
  //   return UserDataBlocState()
  //     ..email = email ?? this.email
  //     ..token = token ?? this.token
  //     ..isLogin = isLogin ?? this.isLogin
  //     ..currentValue = currentValue ?? this.currentValue
  //     ..initialInvestment = initialInvestment ?? this.initialInvestment
  //     ..portfolio = portfolio ?? this.portfolio;
  // }
}

class InitDataUserState extends UserDataState {}

class GetUserDataOKState extends UserDataState {
  final UserData userData;
  final CurrentRequestStatus requestStatus;

  GetUserDataOKState({required this.userData, required this.requestStatus});

  GetUserDataOKState copyWith(
      {UserData? userData, CurrentRequestStatus? requestStatus}) {
    return GetUserDataOKState(
      userData: userData ?? this.userData,
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }
}

class GetUserDataLoginFailState extends UserDataState {
  final UserData userData;
  final CurrentRequestStatus requestStatus;

  GetUserDataLoginFailState(
      {required this.userData, required this.requestStatus});
}
