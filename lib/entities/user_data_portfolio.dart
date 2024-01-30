import 'package:stocks_tracking_app/models/position_model.dart';

class UserDataPortfolio {
  List<PositionModel> portfolio = List<PositionModel>.empty();
  double currentValue = 0;
  double initialInvestment = 0;

  UserDataPortfolio(
      {required this.currentValue,
      required this.initialInvestment,
      required this.portfolio});
}
