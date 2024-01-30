import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:stocks_tracking_app/entities/current_request_status.dart';
import 'package:stocks_tracking_app/entities/user_data_portfolio.dart';
import 'package:stocks_tracking_app/models/user_data_portfolio_model.dart';

class GetPortfolioRequest {
  Future<(UserDataPortfolio, CurrentRequestStatus)> getPortfolio(
      String token) async {
    final response = await http.get(
        Uri.parse("https://stock-server-theta.vercel.app/api/portfolio"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        });

    switch (response.statusCode) {
      case HttpStatus.ok:
        UserDataPortfolioModel userPortfolio =
            UserDataPortfolioModel.fromJson(jsonDecode(response.body));
        return (
          userPortfolio.toUserDataPortfolioEntity(),
          CurrentRequestStatus('', response.statusCode)
        );
      case HttpStatus.badRequest || HttpStatus.unauthorized:
        UserDataPortfolioModel userPortfolio =
            UserDataPortfolioModel.fromJson(jsonDecode(response.body));
        return (
          userPortfolio.toUserDataPortfolioEntity(),
          CurrentRequestStatus('', response.statusCode)
        );
      default:
        UserDataPortfolioModel userPortfolio =
            UserDataPortfolioModel.fromJson(jsonDecode(response.body));
        return (
          userPortfolio.toUserDataPortfolioEntity(),
          CurrentRequestStatus('', response.statusCode)
        );
    }
  }
}
