import 'package:flutter/widgets.dart';

import '../../../core/constants.dart';
import '../../../services/size_utils.dart';

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
        Text(
          label,
          style: TextStyle(fontSize: 12.fSize, color: color),
        ),
        gapSmall,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(fontSize: 12.fSize, color: color),
          ),
        ),
      ],
    );
  }
}
