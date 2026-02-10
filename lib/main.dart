import 'package:amritha_ayurveda/core/router/app_router.dart';
import 'package:amritha_ayurveda/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return ScreenUtilInit(
      designSize: const Size(393, 852), // iPhone 14/15 Pro stats roughly
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          title: 'Amritha Ayurveda',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: goRouter,
        );
      },
    );
  }
}
