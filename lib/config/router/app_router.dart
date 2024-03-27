import 'package:go_router/go_router.dart';
import 'package:stocks_tracking_app/models/position_model.dart';
import 'package:stocks_tracking_app/presentation/pages/screens.dart';

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
      path: '/about',
      name: AboutScreen.name,
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/stockdetails',
      name: StockDetailsScreen.name,
      builder: (context, state) => StockDetailsScreen(
        positionData: state.extra as PositionModel,
      ),
    ),
  ],
);
