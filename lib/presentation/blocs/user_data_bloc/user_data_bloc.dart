import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_tracking_app/entities/current_request_status.dart';
import 'package:stocks_tracking_app/entities/user_data.dart';
import 'package:stocks_tracking_app/helpers/do_login.dart';
import 'package:stocks_tracking_app/helpers/get_portfolio.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(InitDataUserState()) {
    on<DoLogin>(_onDoLogin);
    on<GetPortfolio>(_onGetPorfolio);
  }

  void _onDoLogin(DoLogin event, Emitter<UserDataState> emit) async {
    final DoLoginRequest doLoginRequest = DoLoginRequest();
    final (user, requestStatus) =
        await doLoginRequest.doLogin(event.email, event.password);

    if (user.isLogin) {
      emit(GetUserDataOKState(userData: user, requestStatus: requestStatus));
    } else {
      emit(GetUserDataLoginFailState(
          userData: user, requestStatus: requestStatus));
    }
  }

  void _onGetPorfolio(GetPortfolio event, Emitter<UserDataState> emit) async {
    final GetUserDataOKState getUserDataOKState = state as GetUserDataOKState;
    final (userDataPortfolioModel, requestStatus) = await GetPortfolioRequest()
        .getPortfolio(getUserDataOKState.userData.token);

    emit(getUserDataOKState.copyWith(
        requestStatus: requestStatus,
        userData: getUserDataOKState.userData.copyWith(
            currentValue: userDataPortfolioModel.currentValue,
            initialInvestment: userDataPortfolioModel.initialInvestment,
            portfolio: userDataPortfolioModel.portfolio)));
  }

  void doLogin(String email, String password) {
    add(DoLogin(email: email, password: password));
  }

  void getPortfolio() {
    add(GetPortfolio());
  }
}
