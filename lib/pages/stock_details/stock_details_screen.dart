import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stocks_tracking_app/models/position_model.dart';

class StockDetailsScreen extends StatefulWidget {
  static const String name = 'stock_details_screen';
  static const String link = '/stockdetails';

  const StockDetailsScreen({super.key});

  @override
  State<StockDetailsScreen> createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  ThemeData themeData = ThemeData();

  @override
  Widget build(BuildContext context) {
    final PositionModel positionData =
        GoRouterState.of(context).extra! as PositionModel;
    themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: positionData.name,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
                children: <TextSpan>[
                  TextSpan(
                    text: '\n(${positionData.ticker})',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ])),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: themeData.primaryColor,
      ),
      body: const Center(
        child: Text('Stock Details Screen'),
      ),
    );
  }
}
