import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_tracking_app/config/app_theme.dart';
import 'package:stocks_tracking_app/config/router/app_router.dart';
import 'package:stocks_tracking_app/providers/state_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => StateProvider())],
      child: MaterialApp.router(
        title: 'Stocks Tracking App',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}
