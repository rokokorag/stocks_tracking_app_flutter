import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_tracking_app/entities/current_request_status.dart';
import 'package:stocks_tracking_app/entities/symbolStock.dart';
import 'package:stocks_tracking_app/entities/user_data.dart';
import 'package:stocks_tracking_app/helpers/do_login.dart';
import 'package:stocks_tracking_app/helpers/get_portfolio.dart';
import 'package:stocks_tracking_app/helpers/get_symbol.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(InitDataUserState()) {
    on<DoLogin>(_onDoLogin);
    on<GetPortfolio>(_onGetPorfolio);
    on<GetSymbolInfo>(_onGetSymbolInfo);
  }

  void _onDoLogin(DoLogin event, Emitter<UserDataState> emit) async {
    final DoLoginRequest doLoginRequest = DoLoginRequest();
    final (user, requestStatus) =
        await doLoginRequest.doLogin(event.email, event.password);

    emit(GetUserDataState(userData: user, requestStatus: requestStatus));
  }

  void _onGetPorfolio(GetPortfolio event, Emitter<UserDataState> emit) async {
    print("_onGetPorfolio");
    final GetUserDataState getUserDataOKState = state as GetUserDataState;
    final (userDataPortfolioModel, requestStatus) = await GetPortfolioRequest()
        .getPortfolio(getUserDataOKState.userData.token);

    emit(getUserDataOKState.copyWith(
        requestStatus: requestStatus,
        userData: getUserDataOKState.userData.copyWith(
            currentValue: userDataPortfolioModel.currentValue,
            initialInvestment: userDataPortfolioModel.initialInvestment,
            portfolio: userDataPortfolioModel.portfolio)));
  }

  void _onGetSymbolInfo(
      GetSymbolInfo event, Emitter<UserDataState> emit) async {
    print("_onGetSymbolInfo");
    final GetUserDataState getUserDataState = state as GetUserDataState;

    final (userDataPortfolioModel, requestStatus) = await GetSymbolRequest()
        .getSymbolInfo(getUserDataState.userData.token, event.symbol);

    emit(getUserDataState.copyWith(
        requestStatus: requestStatus,
        symbolStockDetails: userDataPortfolioModel));

    // emit(GetSymbolInfoState(
    //     requestStatus: requestStatus,
    //     symbolStockDetails: userDataPortfolioModel));
  }

  void doLogin(String email, String password) {
    add(DoLogin(email: email, password: password));
  }

  void getPortfolio() {
    add(GetPortfolio());
  }

  void getSymbolInfo(String symbol) {
    add(GetSymbolInfo(symbol: symbol));
  }
}
