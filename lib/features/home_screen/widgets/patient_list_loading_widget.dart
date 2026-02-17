import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class PatientListLoadingWidget extends StatelessWidget {
  final double progress;

  const PatientListLoadingWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular progress with percentage inside
          Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      color: const Color(0xFF006837), // Theme green
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF006837),
                    ),
                  ),
                ],
              )
              .animate()
              .scale(duration: 400.ms, curve: Curves.easeOutBack)
              .fadeIn(duration: 400.ms),
          const Gap(24),
          // Loading text
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
          const Gap(8),
          const Text(
            'Please wait while we fetch the data',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }
}
