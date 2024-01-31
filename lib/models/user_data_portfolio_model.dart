import 'package:stocks_tracking_app/entities/user_data_portfolio.dart';
import 'package:stocks_tracking_app/models/position_model.dart';

class UserDataPortfolioModel {
  final List<PositionModel> positions;
  final double currentValue;
  final double initialInvestment;

  UserDataPortfolioModel(
      {required this.positions,
      required this.currentValue,
      required this.initialInvestment});

  factory UserDataPortfolioModel.fromJson(Map<String, dynamic> json) {
    Iterable listPositions = json['positions'];
    List<PositionModel> positions =
        listPositions.map((i) => PositionModel.fromJson(i)).toList();

    return UserDataPortfolioModel(
        currentValue: double.tryParse(json['current_value'].toString()) ?? 0.0,
        initialInvestment:
            double.tryParse(json['initial_investment'].toString()) ?? 0.0,
        positions: positions);
  }

  // factory UserDataModel.fromJsonError(Map<String, dynamic> json) =>
  //     UserDataModel(token: json['error']);

  UserDataPortfolio toUserDataPortfolioEntity() => UserDataPortfolio(
      currentValue: currentValue,
      initialInvestment: initialInvestment,
      portfolio: positions);
}
