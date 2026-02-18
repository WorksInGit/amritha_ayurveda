import 'package:flutter/widgets.dart';

import '../../../core/constants.dart';
import '../../../services/size_utils.dart';
import '../../../theme/theme.dart';

class CountChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const CountChip({
    super.key,
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: context.poppins40012.copyWith(color: color)),
        gapSmall,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
          decoration: BoxDecoration(
            border: Border.all(color: color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(count.toString(), style: context.poppins40012),
        ),
      ],
    );
  }
}
