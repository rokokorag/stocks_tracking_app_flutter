import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';
//import 'package:stocks_tracking_app/entities/current_request_status.dart';
import 'package:stocks_tracking_app/entities/symbolStock.dart';
//import 'package:stocks_tracking_app/helpers/get_symbol.dart';
import 'package:stocks_tracking_app/models/position_model.dart';
import 'package:stocks_tracking_app/presentation/blocs/user_data_bloc/user_data_bloc.dart';
//import 'package:stocks_tracking_app/providers/state_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StockDetailsScreen extends StatefulWidget {
  static const String name = 'stock_details_screen';
  static const String link = '/stockdetails';

  final PositionModel positionData;

  const StockDetailsScreen({super.key, required this.positionData});

  @override
  State<StockDetailsScreen> createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  ThemeData themeData = ThemeData();
  @override
  void initState() {
    super.initState();
    context.read<UserDataBloc>().getSymbolInfo(widget.positionData.ticker);
  }

  @override
  Widget build(BuildContext context) {
    // final PositionModel positionData =
    //     GoRouterState.of(context).extra! as PositionModel;
    final PositionModel positionData = widget.positionData;
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
        body: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (context, state) {
            if (state is GetUserDataState) {
              final GetUserDataState symbolInfoState = state;

              if (symbolInfoState.symbolStockDetails == null) {
                return const Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (symbolInfoState.requestStatus.httpCode != HttpStatus.ok) {
                return Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Text('Error: ${symbolInfoState.requestStatus.details}')
                    ],
                  ),
                );
              }

              return _StockDetails(
                  positionData: positionData,
                  symbolStockDetails: symbolInfoState.symbolStockDetails!);
            } else {
              return const Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}

class _StockDetails extends StatelessWidget {
  final PositionModel positionData;
  final SymbolStock symbolStockDetails;
  const _StockDetails({
    required this.positionData,
    required this.symbolStockDetails,
  });

  String formatDate(String stringDate) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd");
    DateFormat outputFormat = DateFormat("MMMM dd, yyyy");
    DateTime dateTime = inputFormat.parse(stringDate);
    return outputFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat f = NumberFormat('#,##0.00', 'en_US');
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                positionData.logoUrl,
                width: 50,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(symbolStockDetails.description),
            const SizedBox(height: 15),
            _TextRichStockDetails(
                label: 'Your positions:',
                symbolStockDetails:
                    '${positionData.quantity} stocks (\$${f.format((positionData.averagePrice * positionData.quantity))} ${positionData.currency})'),
            const SizedBox(height: 15),
            _TextRichStockDetails(
                label: 'Last price:',
                symbolStockDetails:
                    '\$${f.format(symbolStockDetails.lastPrice)} ${symbolStockDetails.currency}'),
            const SizedBox(height: 15),
            _TextRichStockDetails(
                label: 'Address:',
                symbolStockDetails: symbolStockDetails.address),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: 'Website: ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: symbolStockDetails.website,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(symbolStockDetails.website));
                        }),
                ],
              ),
            ),
            const SizedBox(height: 15),
            _TextRichStockDetails(
                label: 'Phone:',
                symbolStockDetails: symbolStockDetails.phoneNumber),
            const SizedBox(height: 15),
            _TextRichStockDetails(
                label: 'Industry:',
                symbolStockDetails: symbolStockDetails.industry),
            const SizedBox(height: 15),
            _TextRichStockDetails(
                label: 'IPO Date:',
                symbolStockDetails: formatDate(symbolStockDetails.ipoDate)),
            const SizedBox(height: 15),
            _TextRichStockDetails(
                label: 'Type:', symbolStockDetails: symbolStockDetails.type),
          ],
        ),
      ),
    );
  }
}

class _TextRichStockDetails extends StatelessWidget {
  const _TextRichStockDetails({
    required this.symbolStockDetails,
    required this.label,
  });

  final String symbolStockDetails;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
              text: symbolStockDetails,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
