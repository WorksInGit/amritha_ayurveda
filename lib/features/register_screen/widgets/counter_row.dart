import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../services/size_utils.dart';
import '../../../theme/theme.dart';

class CounterRow extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterRow({
    super.key,
    required this.label,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120.w,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
          ),
          child: Text(
            label,
            style: context.poppins40016.copyWith(fontSize: 16.fSize),
          ),
        ),
        const Spacer(),
        CircleButton(
          icon: Icons.remove,
          onTap: onDecrement,
          color: const Color(0xFF006837),
        ),
        Gap(12.w),
        Container(
          width: 50.w,
          height: 50.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            count.toString(),
            style: context.poppins50018.copyWith(fontSize: 18.fSize),
          ),
        ),
        Gap(12.w),
        CircleButton(
          icon: Icons.add,
          onTap: onIncrement,
          color: const Color(0xFF006837),
        ),
      ],
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 24.r),
      ),
    );
  }
}
