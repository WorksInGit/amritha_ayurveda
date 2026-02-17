import 'package:amritha_ayurveda/constants.dart';
import 'package:amritha_ayurveda/models/treatment_model.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/services/snackbar_utils.dart';
import 'package:flutter/material.dart';

import '../register_screen.dart';

class TreatmentSection extends StatelessWidget {
  final List<Treatment> treatments;
  final List<SelectedTreatment> selectedTreatments;
  final VoidCallback onChanged;

  const TreatmentSection({
    super.key,
    required this.treatments,
    required this.selectedTreatments,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treatments',
          style: TextStyle(
            fontSize: 14.fSize,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        gap,
        // Selected treatments list
        ...selectedTreatments.asMap().entries.map((entry) {
          final index = entry.key;
          final st = entry.value;
          return _TreatmentCard(
            index: index,
            selectedTreatment: st,
            onRemove: () {
              selectedTreatments.removeAt(index);
              onChanged();
            },
            onEdit: () => _showEditDialog(context, st),
          );
        }),

        // Add Treatments button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showAddSheet(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor.withValues(alpha: 0.15),
              foregroundColor: primaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              '+ Add Treatments',
              style: TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddSheet(BuildContext context) {
    final availableTreatments = treatments
        .where((t) => !selectedTreatments.any((st) => st.treatment.id == t.id))
        .toList();

    if (availableTreatments.isEmpty) {
      showErrorMessage('All treatments have been added');
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  gapLarge,
                  Text(
                    'Select Treatment',
                    style: TextStyle(
                      fontSize: 18.fSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  gapLarge,
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: availableTreatments.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final treatment = availableTreatments[index];
                        return ListTile(
                          title: Text(treatment.name),
                          contentPadding: EdgeInsets.zero,
                          onTap: () {
                            selectedTreatments.add(
                              SelectedTreatment(treatment: treatment),
                            );
                            onChanged();
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, SelectedTreatment st) {
    final maleController = TextEditingController(text: st.maleCount.toString());
    final femaleController = TextEditingController(
      text: st.femaleCount.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(st.treatment.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: maleController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Male Count'),
              ),
              gap,
              TextField(
                controller: femaleController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Female Count'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                st.maleCount = int.tryParse(maleController.text) ?? 0;
                st.femaleCount = int.tryParse(femaleController.text) ?? 0;
                onChanged();
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(color: primaryColor)),
            ),
          ],
        );
      },
    );
  }
}

class _TreatmentCard extends StatelessWidget {
  final int index;
  final SelectedTreatment selectedTreatment;
  final VoidCallback onRemove;
  final VoidCallback onEdit;

  const _TreatmentCard({
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
                  '${index + 1}.  ${selectedTreatment.treatment.name}',
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
          const SizedBox(height: 8),
          Row(
            children: [
              _CountChip(
                label: 'Male',
                count: selectedTreatment.maleCount,
                color: primaryColor,
              ),
              const SizedBox(width: 16),
              _CountChip(
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

class _CountChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CountChip({
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
        const SizedBox(width: 4),
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
