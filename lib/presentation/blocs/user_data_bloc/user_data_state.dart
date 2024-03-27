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

class GetUserDataState extends UserDataState {
  final UserData userData;
  final CurrentRequestStatus requestStatus;
  SymbolStock? symbolStockDetails;

  GetUserDataState(
      {required this.userData,
      required this.requestStatus,
      this.symbolStockDetails});

  GetUserDataState copyWith(
      {UserData? userData,
      CurrentRequestStatus? requestStatus,
      SymbolStock? symbolStockDetails}) {
    return GetUserDataState(
      userData: userData ?? this.userData,
      requestStatus: requestStatus ?? this.requestStatus,
      symbolStockDetails: symbolStockDetails,
    );
  }
}

class GetSymbolInfoState extends UserDataState {
  final SymbolStock symbolStockDetails;
  final CurrentRequestStatus requestStatus;

  GetSymbolInfoState(
      {required this.symbolStockDetails, required this.requestStatus});
}
