import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'core/app_route.dart';
import 'core/repository.dart';
import 'theme/theme.dart';
import 'services/shared_preferences_services.dart';

final navigatorKey = GlobalKey<NavigatorState>();

mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.i.initialize();
  await DataRepository.i.initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setSystemOverlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder:
          (
            BuildContext context,
            Orientation orientation,
            DeviceType deviceType,
          ) {
            return ToastificationWrapper(
              child: MaterialApp(
                theme: themeData,
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRoute.onGenerateRoute,
                onGenerateInitialRoutes: AppRoute.onGenerateInitialRoute,
              ),
            );
          },
    );
  }
}
