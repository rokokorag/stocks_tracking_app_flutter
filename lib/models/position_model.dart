class PositionModel {
  final String ticker;
  final String name;
  final int quantity;
  final double averagePrice;
  final double lastPrice;
  final String currency;
  final String type;
  final String logoUrl;

  PositionModel(
      {required this.ticker,
      required this.name,
      required this.quantity,
      required this.averagePrice,
      required this.lastPrice,
      required this.currency,
      required this.type,
      required this.logoUrl});

  factory PositionModel.fromJson(Map<String, dynamic> json) => PositionModel(
      name: json['name'],
      ticker: json['ticker'],
      quantity: json['quantity'],
      averagePrice: json['average_price'],
      lastPrice: double.parse(json['last_price']),
      currency: json['currency'],
      type: json['type'],
      logoUrl: json['logo_url']);
}
