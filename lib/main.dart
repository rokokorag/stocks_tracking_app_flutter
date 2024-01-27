import 'package:flutter/material.dart';
import 'package:stocks_tracking_app/config/router/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stocks Tracking App',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
