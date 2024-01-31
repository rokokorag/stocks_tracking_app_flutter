import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stocks_tracking_app/models/position_model.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<StateProvider>().getPortfolio();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<PositionModel> positions =
        context.watch<StateProvider>().userData.portfolio;
    double currentValue = context.watch<StateProvider>().userData.currentValue;
    double initialInvestment =
        context.watch<StateProvider>().userData.initialInvestment;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stocks Tracking App'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\$${f.format(currentValue)}',
              style: theme.textTheme.titleLarge,
            ),
            Text(
              '\$${f.format(currentValue - initialInvestment)} (${(((currentValue - initialInvestment) / initialInvestment) * 100).toStringAsFixed(2)}%)',
              style: theme.textTheme.titleMedium,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: positions.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
              itemBuilder: (context, index) {
                final position = positions[index];
                return _StockListItem(
                  position: position,
                );
              },
            ),
          ],
        ),
      ),
      drawer: const SideMenu(
        selectedMenu: 0,
      ),
    );
  }
}

class _StockListItem extends StatelessWidget {
  final PositionModel position;
  final NumberFormat f = NumberFormat('#,##0.00', 'en_US');
  _StockListItem({required this.position});

  @override
  Widget build(BuildContext context) {
    final diferencePrice = position.lastPrice - position.averagePrice;
    final pctGain =
        (((position.lastPrice - position.averagePrice) / position.lastPrice) *
            100);

    return ListTile(
      title: Text('${position.name} (${position.ticker})'),
      subtitle: Text('${position.quantity.toString()} stocks'),
      leading: Image.network(
        position.logoUrl,
        height: 20,
        width: 20,
        fit: BoxFit.fitWidth,
      ),
      trailing: Column(
        children: [
          Text(
            '\$${f.format(position.lastPrice)}',
            textAlign: TextAlign.right,
          ),
          Text(
            '${(diferencePrice > 0 ? '+' : '')}${f.format(diferencePrice)} (${(pctGain > 0 ? '+' : '')}${(pctGain).toStringAsFixed(2)})%',
            textAlign: TextAlign.end,
          ),
          // const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
      onTap: () {},
    );
  }
}
