import 'package:go_router/go_router.dart';
import 'package:stocks_tracking_app/pages/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      name: PortfolioScreen.name,
      builder: (context, state) => const PortfolioScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/stockdetails',
      name: StockDetailsScreen.name,
      builder: (context, state) => const StockDetailsScreen(),
    ),
  ],
);
