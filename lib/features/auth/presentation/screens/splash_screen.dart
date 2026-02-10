import 'package:amritha_ayurveda/core/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
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

  _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      // Navigate to Login Screen
      // Replacing with literal path for now as router constants aren't created yet
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(AssetConstants.splashBackground, fit: BoxFit.cover),

          // Dark Overlay (Optional, based on design it looks dark)
          Container(
            color: Colors.black.withValues(
              alpha: 0.5,
            ), // Adjust opacity as needed
          ),

          // Logo
          Center(
            child: SvgPicture.asset(AssetConstants.splashLogo, width: 134.w),
          ),
        ],
      ),
    );
  }
}
