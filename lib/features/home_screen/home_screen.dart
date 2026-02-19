import 'dart:async';
import 'package:amritha_ayurveda/core/app_route.dart';

import 'package:amritha_ayurveda/core/repository.dart';

import 'package:amritha_ayurveda/features/home_screen/widgets/patient_list_loading_widget.dart';
import 'package:amritha_ayurveda/widgets/logout_bottom_sheet.dart';
import 'package:amritha_ayurveda/features/register_screen/register_screen.dart';
import 'package:amritha_ayurveda/features/register_screen/models/patient_model.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/widgets/app_button.dart';
import 'package:amritha_ayurveda/widgets/network_resource.dart';
import 'package:amritha_ayurveda/features/home_screen/widgets/patient_card.dart';
import 'package:flutter/material.dart';

import '../../core/constants.dart';

class HomeScreen extends StatefulWidget {
  static const String path = "/home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<Future<List<Patient>>?> patientListFutureNotifier =
      ValueNotifier(null);
  final ValueNotifier<double> downloadProgressNotifier = ValueNotifier(0.0);
  Timer? progressTimer;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    progressTimer?.cancel();
    patientListFutureNotifier.dispose();
    downloadProgressNotifier.dispose();
    super.dispose();
  }

  void startSimulatedProgress() {
    progressTimer?.cancel();
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      double increment = 0.0;
      final currentProgress = downloadProgressNotifier.value;
      if (currentProgress < 0.6) {
        increment = 0.05;
      } else if (currentProgress < 0.85) {
        increment = 0.01;
      } else if (currentProgress < 0.95) {
        increment = 0.002;
      } else {
        timer.cancel();
        return;
      }

      if (mounted) {
        double newValue = currentProgress + increment;
        if (newValue > 0.99) {
          newValue = 0.99;
        }
        downloadProgressNotifier.value = newValue;
      }
    });
  }

  Future<void> getData() async {
    downloadProgressNotifier.value = 0.05;
    startSimulatedProgress();
    final future = DataRepository.i.getPatientList(
      onReceiveProgress: (count, total) {
        if (total != -1) {
          progressTimer?.cancel();
          final realProgress = count / total;
          if (mounted && realProgress > downloadProgressNotifier.value) {
            downloadProgressNotifier.value = realProgress;
          }
        }
      },
    );
    patientListFutureNotifier.value = future;

    await future;
    progressTimer?.cancel();
    if (mounted) {
      downloadProgressNotifier.value = 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amritha Ayurveda'),
        actions: [
          ValueListenableBuilder<double>(
            valueListenable: downloadProgressNotifier,
            builder: (context, progress, child) {
              return Visibility(
                visible: progress == 1.0,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_horiz, color: Colors.white),
                  onSelected: (value) {
                    if (value == 'logout') {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => const LogoutBottomSheet(),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.black),
                          gap,
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<Future<List<Patient>>?>(
        valueListenable: patientListFutureNotifier,
        builder: (context, patientListFuture, child) {
          return ValueListenableBuilder<double>(
            valueListenable: downloadProgressNotifier,
            builder: (context, progress, child) {
              return NetworkResource<List<Patient>>(
                patientListFuture,
                loading: PatientListLoadingWidget(progress: progress),
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
                      padding: EdgeInsets.all(20.w),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.w),
                          child: PatientCard(
                            patient: data[index],
                            index: index + 1,
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<double>(
        valueListenable: downloadProgressNotifier,
        builder: (context, progress, child) {
          return Visibility(
            visible: progress == 1.0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0.w, 0, 16.0.w, 30.0.w),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: AppButton(
                  text: 'Register Now',
                  onPressed: () async {
                    final result = await navigate(context, RegisterScreen.path);
                    if (result == true) {
                      getData();
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
