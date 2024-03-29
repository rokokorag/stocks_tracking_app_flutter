import 'package:stocks_tracking_app/models/position_model.dart';

class UserData {
  final String email;
  final String token;
  final bool isLogin;
  List<PositionModel> portfolio = List<PositionModel>.empty();
  double currentValue = 0;
  double initialInvestment = 0;

  UserData({required this.email, required this.token, required this.isLogin});
}
