import 'package:flutter/material.dart';
import '../features/home_screen/home_screen.dart';
import '../features/register_screen/register_screen.dart';
import '../features/splash_screen/splash_screen.dart';
import '../features/login_screen/login_screen.dart';
import 'logger.dart';

class AppRoute {
  static List<Route<dynamic>> onGenerateInitialRoute(String path) {
    Uri uri = Uri.parse(path);
    logInfo(uri);
    return [
      pageRoute(
        const RouteSettings(name: SplashScreen.path),
        const SplashScreen(),
      ),
    ];
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    logInfo(settings.name);
    Uri uri = Uri.parse(settings.name ?? "");
    final Widget screen;

    switch (uri.path) {
      case SplashScreen.path:
        screen = const SplashScreen();
        // return pageRoute(settings, screen, animate: false);
        break;

      case HomeScreen.path:
        screen = const HomeScreen();
        return pageRoute(settings, screen);

      case LoginScreen.path:
        screen = const LoginScreen();
        return pageRoute(settings, screen);

      case RegisterScreen.path:
        screen = const RegisterScreen();
        return pageRoute(settings, screen);

      default:
        return null;
    }
    return null;
  }
}

Route<T> pageRoute<T>(
  RouteSettings settings,
  Widget screen, {
  bool animate = true,
}) {
  if (!animate) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      opaque: true,
      pageBuilder: (context, animation, secondaryAnimation) => screen,
    );
  }
  return MaterialPageRoute(settings: settings, builder: (context) => screen);
}

Future<T?> navigate<T extends Object?>(
  BuildContext context,
  String routeName, {
  Object? arguments,
  bool duplicate = false,
  bool replace = false,
}) async {
  final currentRoute = ModalRoute.of(context)?.settings.name;
  if (routeName == currentRoute && !duplicate) return null;
  if (replace) {
    return await Navigator.of(context).pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  } else {
    return await Navigator.of(
      context,
    ).pushNamed<T>(routeName, arguments: arguments);
  }
}
