// import 'dart:core';
// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'app_config.dart';
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'token_auth_interceptor.dart';

// class DataRepository {
//   final Dio _client;

//   DataRepository._(this._client);

//   /// Factory method to create and initialize the repository
//   static Future<DataRepository> create() async {
//     final client = Dio(
//       BaseOptions(
//         connectTimeout: const Duration(seconds: 60),
//         baseUrl: appConfig.baseUrl,
//         contentType: "application/json",
//       ),
//     );

//     final cookieJar = CookieJar(ignoreExpires: false);
//     client.interceptors.add(CookieManager(cookieJar));
//     client.interceptors.add(TokenAuthInterceptor());
//     client.interceptors.add(
//       PrettyDioLogger(
//         requestBody: true,
//         responseBody: true,
//         requestHeader: true,
//         responseHeader: true,
//         error: true,
//         compact: true,
//       ),
//     );
//     client.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           await Future.delayed(const Duration(seconds: 1));
//           handler.next(options);
//         },
//       ),
//     );

//     return DataRepository._(client);
//   }

//   // Singleton instance
//   static DataRepository? _instance;
//   static DataRepository get i {
//     if (_instance == null) {
//       throw StateError(
//         'DataRepository.i accessed before initialization. '
//         'Ensure DataRepository.create() is called and assigned to _instance.',
//       );
//     }
//     return _instance!;
//   }

//   // Initialize the singleton
//   static Future<void> initialize() async {
//     _instance = await create();
//   }

//   void setBaseUrl(String text) {
//     _client.options.baseUrl = text + appConfig.slugUrl;
//   }
// }

import 'dart:convert';
import 'dart:core';
import 'package:amritha_ayurveda/core/api_constants.dart';
import 'package:amritha_ayurveda/core/error_exception_handler.dart';
import 'package:amritha_ayurveda/models/branch_model.dart';
import 'package:amritha_ayurveda/models/patient_model.dart';
import 'package:amritha_ayurveda/models/treatment_model.dart';
import 'package:amritha_ayurveda/services/shared_preferences_services.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_config.dart';
import 'token_auth_interceptor.dart';

class DataRepository {
  DataRepository._private();
  late final Dio _client;

  bool initialized = false;

  // Future<List<ActivityModel>>? _featuredActivities;
  Future<void> initialize() async {
    if (initialized) return;

    _client = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        baseUrl: appConfig.baseUrl,
        contentType: "application/json",
      ),
    );
    var cookieJar = CookieJar(ignoreExpires: false);
    _client.interceptors.add(CookieManager(cookieJar));
    _client.interceptors.add(TokenAuthInterceptor());
    _client.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
        compact: true,
      ),
    );
    _client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          await Future.delayed(const Duration(seconds: 1));
          handler.next(options);
        },
      ),
    );
    initialized = true;
  }

  static DataRepository get i => _instance;
  static final DataRepository _instance = DataRepository._private();

  void setBaseUrl(String text) {
    _client.options.baseUrl = text + appConfig.slugUrl;
  }

  Future<Response> login({
    required String username,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {"username": username, "password": password};
      final response = await _client.post(
        APIConstants.login,
        data: FormData.fromMap(data),
      );
      if (response.data['status'] == true) {
        await SharedPreferencesService.i.setValue(
          value: response.data['token'],
        );
      }
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<List<Patient>> getPatientList({
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _client.get(
        APIConstants.patientList,
        options: Options(responseType: ResponseType.plain),
        onReceiveProgress: onReceiveProgress,
      );
      return await compute(parsePatients, response.data.toString());
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<List<Branch>> getBranchList() async {
    try {
      final response = await _client.get(APIConstants.branchList);
      final data = response.data;
      if (data is List) {
        return data.map<Branch>((json) => Branch.fromJson(json)).toList();
      }
      if (data is Map && data['branches'] != null) {
        return (data['branches'] as List)
            .map<Branch>((json) => Branch.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<List<Treatment>> getTreatmentList({required int branchId}) async {
    try {
      final response = await _client.get(APIConstants.treatmentList);
      final data = response.data;

      List<dynamic> treatmentsList = [];

      if (data is List) {
        treatmentsList = data;
      } else if (data is Map && data['treatments'] != null) {
        treatmentsList = data['treatments'] as List;
      }

      // Filter treatments that belong to the selected branch
      if (branchId != 0) {
        treatmentsList = treatmentsList.where((json) {
          final branches = json['branches'] as List? ?? [];
          return branches.any((branch) => branch['id'] == branchId);
        }).toList();
      }

      return treatmentsList
          .map<Treatment>((json) => Treatment.fromJson(json))
          .toList();
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<Response> registerPatient({
    required String name,
    required String excecutive,
    required String payment,
    required String phone,
    required String address,
    required String totalAmount,
    required String discountAmount,
    required String advanceAmount,
    required String balanceAmount,
    required String dateAndTime,
    required String id,
    required String male,
    required String female,
    required String branch,
    required String treatments,
  }) async {
    try {
      final data = {
        'name': name,
        'excecutive': excecutive,
        'payment': payment,
        'phone': phone,
        'address': address,
        'total_amount': totalAmount,
        'discount_amount': discountAmount,
        'advance_amount': advanceAmount,
        'balance_amount': balanceAmount,
        'date_nd_time': dateAndTime,
        'id': id,
        'male': male,
        'female': female,
        'branch': branch,
        'treatments': treatments,
      };
      final response = await _client.post(
        APIConstants.patientUpdate,
        data: FormData.fromMap(data),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }
}

// Top-level function for background parsing
List<Patient> parsePatients(String responseBody) {
  final parsed = jsonDecode(responseBody);
  if (parsed['status'] == true && parsed['patient'] != null) {
    return (parsed['patient'] as List)
        .map<Patient>((json) => Patient.fromJson(json))
        .toList();
  } else if (parsed['status'] == false) {
    throw Exception(parsed['message']);
  }
  return [];
}
