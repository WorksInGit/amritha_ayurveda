import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../services/size_utils.dart';
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
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
                  style: TextStyle(
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.cancel,
                  color: Colors.red[400],
                  size: 24.fSize,
                ),
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
              const SizedBox(width: 16),
              CountChip(
                label: 'Female',
                count: selectedTreatment.femaleCount,
                color: Colors.black87,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onEdit,
                child: Icon(Icons.edit, size: 20.fSize, color: primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
