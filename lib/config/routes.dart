import 'package:flutter/material.dart';
import 'package:nutralis_flutter/presentation/product/result/product_result_screen.dart';
import 'package:nutralis_flutter/presentation/product/scanner/scanner_screen.dart';
import '../presentation/auth/login_screen.dart';
import '../presentation/auth/register_screen.dart';
import '../presentation/home/home_screen.dart';
// import '../presentation/scanner/scanner_screen.dart';
// import '../presentation/product/product_details_screen.dart';
import '../presentation/search/search_screen.dart';
import '../presentation/compare/compare_screen.dart';
// import '../presentation/history/history_screen.dart';
// import '../presentation/profile/profile_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String scanner = '/scanner';
  static const String productResult = '/product-result';
  static const String search = '/search';
  static const String compare = '/compare';
  static const String history = '/history';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case scanner:
        return MaterialPageRoute(builder: (_) => const ScannerScreen());
      case productResult:
        final barcode = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductResultScreen(barcode: barcode),
        );
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case compare:
        return MaterialPageRoute(builder: (_) => const ComparePage());
      // case history:
      //   return MaterialPageRoute(builder: (_) => const HistoryScreen());
      // case profile:
      //   return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
