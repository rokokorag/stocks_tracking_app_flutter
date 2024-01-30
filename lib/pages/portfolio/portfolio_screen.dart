import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<StateProvider>().getPortfolio();
  }

  @override
  Widget build(BuildContext context) {
    print(context.watch<StateProvider>().userData.currentValue);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stocks Tracking App'),
      ),
      body: ListView.separated(
        itemCount: context.read<StateProvider>().userData.portfolio.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1),
        itemBuilder: (context, index) {
          final position =
              context.read<StateProvider>().userData.portfolio[index];
          return _StockListItem(
            position: position,
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
  const _StockListItem({required this.position});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${position.name} (${position.ticker})'),
      subtitle: Text('${position.quantity.toString()} stocks'),
      leading: Image.network(
        position.logoUrl,
        height: 25,
        width: 25,
        fit: BoxFit.fitWidth,
      ),
      trailing: Column(
        children: [
          Text(
            '\$${position.lastPrice.toStringAsFixed(2)}',
            textAlign: TextAlign.right,
          ),
          Text(
            '+ ${position.averagePrice.toStringAsFixed(2)} (${(((position.averagePrice - position.lastPrice) / position.lastPrice) * 100).toStringAsFixed(2)})%',
            textAlign: TextAlign.end,
          ),
          // const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
      onTap: () {},
    );
  }
}
