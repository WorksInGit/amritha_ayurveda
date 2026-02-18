import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../../core/constants.dart';
import '../../../services/size_utils.dart';

class PatientListLoadingWidget extends StatelessWidget {
  final double progress;

  const PatientListLoadingWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80.w,
                    height: 80.w,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      color: const Color(0xFF006837),
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.fSize,
                      color: Color(0xFF006837),
                    ),
                  ),
                ],
              )
              .animate()
              .scale(duration: 400.ms, curve: Curves.easeOutBack)
              .fadeIn(duration: 400.ms),
          Gap(24.w),

          const Text(
                'Loading Patients...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              )
              .animate()
              .fadeIn(delay: 200.ms)
              .slideY(begin: 0.2, end: 0, duration: 400.ms),
          gap,
          const Text(
            'Please wait while we fetch the data',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }
}
