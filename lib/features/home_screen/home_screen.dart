import 'dart:async';
import 'package:amritha_ayurveda/core/app_route.dart';
import 'package:amritha_ayurveda/core/repository.dart';

import 'package:amritha_ayurveda/features/home_screen/widgets/patient_list_loading_widget.dart';
import 'package:amritha_ayurveda/features/register_screen/register_screen.dart';
import 'package:amritha_ayurveda/models/patient_model.dart';
import 'package:amritha_ayurveda/widgets/network_resource.dart';
import 'package:amritha_ayurveda/features/home_screen/widgets/patient_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String path = "/home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Patient>>? patientListFuture;
  double downloadProgress = 0.0;
  Timer? progressTimer;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    progressTimer?.cancel();
    super.dispose();
  }

  void startSimulatedProgress() {
    progressTimer?.cancel();
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (downloadProgress < 0.9) {
        if (mounted) {
          setState(() {
            downloadProgress += 0.05;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> getData() async {
    setState(() {
      downloadProgress = 0.0;
      startSimulatedProgress();
      patientListFuture = DataRepository.i.getPatientList(
        onReceiveProgress: (count, total) {
          if (total != -1) {
            progressTimer?.cancel();
            final progress = count / total;
            if (mounted) {
              setState(() {
                downloadProgress = progress;
              });
            }
          }
        },
      );
    });
    await patientListFuture;
    progressTimer?.cancel();
    if (mounted) {
      setState(() {
        downloadProgress = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Amritha Ayurveda',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: NetworkResource<List<Patient>>(
        patientListFuture,
        loading: PatientListLoadingWidget(progress: downloadProgress),
        error: (error) => Center(child: Text('Error: $error')),
        success: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('No patients found'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              await getData();
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              itemExtent: 175,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PatientCard(patient: data[index], index: index + 1),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Visibility(
        visible: downloadProgress == 1.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 30.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                final result = await navigate(context, RegisterScreen.path);
                if (result == true) {
                  getData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006837), // Theme Green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Register Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
