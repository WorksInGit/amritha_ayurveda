// ignore_for_file: use_build_context_synchronously

import 'package:amritha_ayurveda/core/app_route.dart';
import 'package:amritha_ayurveda/features/home_screen/home_screen.dart';
import 'package:amritha_ayurveda/gen/assets.gen.dart';
import 'package:amritha_ayurveda/services/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/size_utils.dart';
import '../login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String path = "/splash-screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      final token = await SharedPreferencesService.i.getValue();

      if (token.isNotEmpty || token != '') {
        navigate(context, HomeScreen.path, replace: true);
      } else {
        navigate(context, LoginScreen.path, replace: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Assets.pngs.splashBackground.path, fit: BoxFit.cover),

          Container(color: Colors.black.withValues(alpha: 0.5)),

          Center(child: SvgPicture.asset(Assets.svgs.splashLogo, width: 134.h)),
        ],
      ),
    );
  }
}
