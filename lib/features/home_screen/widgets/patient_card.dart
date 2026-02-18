import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:gap/gap.dart';

import '../../../theme/theme.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final int index;

  const PatientCard({super.key, required this.patient, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('$index. ', style: context.poppins50018),
                    Expanded(
                      child: Text(
                        patient.name ?? "N/A",
                        style: context.poppins50018,
                      ),
                    ),
                  ],
                ),
                gap,

                Text(
                  patient.treatmentName ?? "N/A",
                  style: context.poppins30016.copyWith(
                    color: const Color.fromARGB(255, 9, 78, 46),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                gap,

                Visibility(
                  visible:
                      patient.date != null ||
                      (patient.user?.isNotEmpty ?? false),
                  child: Row(
                    children: [
                      Visibility(
                        visible: patient.date != null,
                        child: Icon(
                          Icons.calendar_today_outlined,
                          size: 14.r,
                          color: Color(0xFFDB4437),
                        ),
                      ),
                      gapSmall,
                      Text(
                        patient.date?.toString().substring(0, 10) ?? '',
                        style: context.poppins40015.copyWith(
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                      Gap(24.w),
                      Visibility(
                        visible: patient.user?.isNotEmpty ?? false,
                        child: Icon(
                          Icons.people_outline,
                          size: 14.r,
                          color: Color(0xFFDB4437),
                        ),
                      ),
                      gapSmall,
                      if (patient.user?.isNotEmpty ?? false)
                        Text(
                          "${patient.user![0].toUpperCase()}${patient.user!.substring(1)}",
                          style: context.poppins40012.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(13.w),
          Divider(height: 1.w),
          Gap(13.w),

          Padding(
            padding: EdgeInsets.fromLTRB(36.w, 0, 36.w, 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('View Booking details', style: context.poppins40014),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20.r,
                  color: Color(0xFF389A48),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
