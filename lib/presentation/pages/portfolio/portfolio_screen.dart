import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stocks_tracking_app/models/position_model.dart';
import 'package:stocks_tracking_app/presentation/blocs/user_data_bloc/user_data_bloc.dart';
import 'package:stocks_tracking_app/providers/state_provider.dart';
import 'package:stocks_tracking_app/widgets/side_menu.dart';

class PortfolioScreen extends StatefulWidget {
  static const String name = 'portfolio_screen';
  static const String link = '/';

  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final NumberFormat f = NumberFormat('#,##0.00', 'en_US');
  bool isLoading = false;
  ThemeData themeData = ThemeData();
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    context.read<UserDataBloc>().getPortfolio();
    // With Provider
    //context.read<StateProvider>().getPortfolio();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> onRefresh() async {
    setState(() {
      isLoading = true;
    });
    context.read<UserDataBloc>().getPortfolio();
    // With Provider
    //context.read<StateProvider>().getPortfolio();
    await Future<void>.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    // List<PositionModel> positions =
    //     context.watch<StateProvider>().userData.portfolio;
    // double currentValue = context.watch<StateProvider>().userData.currentValue;
    // double initialInvestment =
    //     context.watch<StateProvider>().userData.initialInvestment;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stocks Tracking App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: themeData.primaryColor,
      ),
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          final userState = (state as GetUserDataOKState);
          return RefreshIndicator(
            onRefresh: onRefresh,
            edgeOffset: 0,
            strokeWidth: 2,
            backgroundColor: themeData.primaryColor,
            color: Colors.white,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Skeletonizer(
                enabled: isLoading,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      // '\$${f.format(currentValue)}',
                      '\$${f.format(userState.userData.currentValue)}',
                      style: themeData.textTheme.headlineLarge,
                    ),
                    Text(
                      //'\$${f.format(currentValue - initialInvestment)} (${(((currentValue - initialInvestment) / initialInvestment) * 100).toStringAsFixed(2)}%)',
                      '\$${f.format(userState.userData.currentValue - userState.userData.initialInvestment)} (${(((userState.userData.currentValue - userState.userData.initialInvestment) / userState.userData.initialInvestment) * 100).toStringAsFixed(2)}%)',
                      style: themeData.textTheme.titleMedium,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userState.userData.portfolio.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                              height: 0,
                              thickness: 1,
                              color: themeData.primaryColor),
                      itemBuilder: (context, index) {
                        final position = userState.userData.portfolio[index];
                        return _StockListItem(
                            position: position, themeData: themeData);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      drawer: const SideMenu(
        selectedMenu: 0,
      ),
    );
  }
}

class _StockListItem extends StatelessWidget {
  final PositionModel position;
  final ThemeData themeData;
  final NumberFormat f = NumberFormat('#,##0.00', 'en_US');
  _StockListItem({required this.position, required this.themeData});

  @override
  Widget build(BuildContext context) {
    final diferencePrice = position.lastPrice - position.averagePrice;
    final pctGain =
        (((position.lastPrice - position.averagePrice) / position.lastPrice) *
            100);

    return ListTile(
      title: Text('${position.name} (${position.ticker})',
          style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text('${position.quantity.toString()} stocks'),
      leading: Image.network(
        position.logoUrl,
        height: 30,
        width: 30,
        fit: BoxFit.fitWidth,
      ),
      dense: false,
      contentPadding: const EdgeInsets.only(left: 10.0, right: 5.0),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${f.format(position.lastPrice)}',
              ),
              Text(
                '${(diferencePrice > 0 ? '+' : '')}${f.format(diferencePrice)} (${(pctGain > 0 ? '+' : '')}${(pctGain).toStringAsFixed(2)})%',
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: themeData.primaryColor,
          )
        ],
      ),
      onTap: () {
        context.push('/stockdetails', extra: position);
      },
    );
  }
}
