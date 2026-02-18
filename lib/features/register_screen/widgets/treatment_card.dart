import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../services/size_utils.dart';
import '../../../theme/theme.dart';
import '../register_screen.dart';
import 'count_chip.dart';

class TreatmentCard extends StatelessWidget {
  final int index;
  final SelectedTreatment selectedTreatment;
  final VoidCallback onRemove;
  final VoidCallback onEdit;

  const TreatmentCard({
    super.key,
    required this.index,
    required this.selectedTreatment,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      padding: EdgeInsets.fromLTRB(12.w, 10.w, 8.w, 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${index + 1}.  ${selectedTreatment.treatment.name ?? 'Unknown'}',
                  style: context.poppins60014,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onRemove,
                child: Icon(Icons.cancel, color: Colors.red[400], size: 24.r),
              ),
            ],
          ),
          gap,
          Row(
            children: [
              CountChip(
                label: 'Male',
                count: selectedTreatment.maleCount,
                color: primaryColor,
              ),
              gapLarge,
              CountChip(
                label: 'Female',
                count: selectedTreatment.femaleCount,
                color: Colors.black87,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onEdit,
                child: Icon(Icons.edit, size: 20.r, color: primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
