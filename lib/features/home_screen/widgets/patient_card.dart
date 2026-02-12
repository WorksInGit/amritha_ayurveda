import 'package:amritha_ayurveda/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final int index;

  const PatientCard({super.key, required this.patient, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Light grey background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Index and Name
                Row(
                  children: [
                    Text(
                      '$index. ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        patient.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(8),

                // Treatment Name
                Text(
                  patient.treatmentName,
                  style: const TextStyle(
                    color: Color(0xFF006837), // Green color
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(12),

                // Date and User
                Row(
                  children: [
                    // Date
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Color(0xFFDB4437), // Reddish icon color
                    ),
                    const Gap(4),
                    Text(
                      patient.date?.toString().substring(0, 10) ?? '',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Gap(24),
                    // User
                    const Icon(
                      Icons.people_outline,
                      size: 14,
                      color: Color(0xFFDB4437), // Reddish icon color
                    ),
                    const Gap(4),
                    Text(
                      patient.user,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Footer: View Booking Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'View Booking details',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xFF006837), // Green arrow
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
