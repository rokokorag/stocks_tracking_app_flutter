import 'package:stocks_tracking_app/entities/symbolStock.dart';

class SymbolModel {
  final String ticker;
  final String name;
  final double lastPrice;
  final String currency;
  final String type;
  final String logoUrl;
  final String description;
  final String website;
  final String sector;
  final String industry;
  final String phoneNumber;
  final String address;
  final String ipoDate;

  SymbolModel(
      {required this.ticker,
      required this.name,
      required this.lastPrice,
      required this.currency,
      required this.type,
      required this.logoUrl,
      required this.description,
      required this.website,
      required this.sector,
      required this.industry,
      required this.phoneNumber,
      required this.address,
      required this.ipoDate});

  factory SymbolModel.fromJson(Map<String, dynamic> json) {
    return SymbolModel(
        ticker: json['ticker'],
        name: json['name'],
        lastPrice: double.tryParse(json['last_price'].toString()) ?? 0.0,
        currency: json['currency'],
        type: json['type'],
        logoUrl: json['logo_url'],
        description: json['description'],
        website: json['website'],
        sector: json['sector'],
        industry: json['industry'],
        phoneNumber: json['phone_number'],
        address: json['address'],
        ipoDate: json['ipo_date']);
  }

  SymbolStock toSymbolStockEntity() {
    SymbolStock symbolStock = SymbolStock();
    symbolStock.ticker = ticker;
    symbolStock.name = name;
    symbolStock.lastPrice = lastPrice;
    symbolStock.currency = currency;
    symbolStock.type = type;
    symbolStock.logoUrl = logoUrl;
    symbolStock.description = description;
    symbolStock.website = website;
    symbolStock.sector = sector;
    symbolStock.industry = industry;
    symbolStock.phoneNumber = phoneNumber;
    symbolStock.address = address;
    symbolStock.ipoDate = ipoDate;
    return symbolStock;
  }
}
