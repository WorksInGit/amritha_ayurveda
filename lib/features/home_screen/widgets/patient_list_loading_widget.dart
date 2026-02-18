import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../../core/constants.dart';
import '../../../services/size_utils.dart';
import '../../../theme/theme.dart';

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
                    style: context.poppins60018.copyWith(
                      color: Color(0xFF006837),
                    ),
                  ),
                ],
              )
              .animate()
              .scale(duration: 400.ms, curve: Curves.easeOutBack)
              .fadeIn(duration: 400.ms),
          Gap(24.w),

          Text(
                'Loading Patients...',
                style: context.poppins50016.copyWith(color: Colors.grey),
              )
              .animate()
              .fadeIn(delay: 200.ms)
              .slideY(begin: 0.2, end: 0, duration: 400.ms),
          gap,
          Text(
            'Please wait while we fetch the data',
            style: context.poppins40012.copyWith(color: Colors.grey),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }
}
