import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:stocks_tracking_app/entities/current_request_status.dart';
import 'package:stocks_tracking_app/entities/symbolStock.dart';
import 'package:stocks_tracking_app/models/symbol_model.dart';

class GetSymbolRequest {
  Future<(SymbolStock, CurrentRequestStatus)> getSymbolInfo(
      String token, String symbol) async {
    final response = await http.get(
        Uri.parse("https://stock-server-theta.vercel.app/api/symbol/$symbol"),
        headers: <String, String>{
          'Authorization': token,
        });

    switch (response.statusCode) {
      case HttpStatus.ok:
        SymbolModel symbolModel =
            SymbolModel.fromJson(jsonDecode(response.body));
        return (
          symbolModel.toSymbolStockEntity(),
          CurrentRequestStatus('', response.statusCode)
        );
      case HttpStatus.badRequest || HttpStatus.unauthorized:
        return (
          SymbolStock(),
          CurrentRequestStatus('Unauthorized', response.statusCode)
        );
      default:
        return (
          SymbolStock(),
          CurrentRequestStatus('ERROR Response', response.statusCode)
        );
    }
  }
}
