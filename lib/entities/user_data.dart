import 'package:stocks_tracking_app/models/position_model.dart';

class UserData {
  final String email;
  final String token;
  final bool isLogin;
  List<PositionModel> portfolio = List<PositionModel>.empty();
  double currentValue = 0;
  double initialInvestment = 0;

  UserData({required this.email, required this.token, required this.isLogin});

  UserData copyWith(
      {String? email,
      String? token,
      bool? isLogin,
      double? currentValue,
      double? initialInvestment,
      List<PositionModel>? portfolio}) {
    return UserData(
      email: email ?? this.email,
      token: token ?? this.token,
      isLogin: isLogin ?? this.isLogin,
    )
      ..currentValue = currentValue ?? this.currentValue
      ..initialInvestment = initialInvestment ?? this.initialInvestment
      ..portfolio = portfolio ?? this.portfolio;
  }
}
