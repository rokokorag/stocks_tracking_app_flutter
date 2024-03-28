part of 'user_data_bloc.dart';

abstract class UserDataState {}

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
