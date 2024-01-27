import 'package:go_router/go_router.dart';
import 'package:stocks_tracking_app/pages/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PortfolioScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/stockdetails',
      builder: (context, state) => const StockDetailsScreen(),
    ),
  ],
);
