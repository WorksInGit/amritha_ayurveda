// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum CustomExceptionType {
  cannotReachServer,
  noNetwork,
  somethingWentWrong,
  invalidUrl,
  internalServerError;

  @override
  String toString() {
    return text;
  }

  String get text {
    switch (this) {
      case CustomExceptionType.cannotReachServer:
        return "Server cannot be reached!";
      case CustomExceptionType.noNetwork:
        return "Please check your network connection!";
      case CustomExceptionType.somethingWentWrong:
        return "Something went wrong!";
      case CustomExceptionType.invalidUrl:
        return "Please enter a valid url";
      case CustomExceptionType.internalServerError:
        return "Internal server error!";
    }
  }

  Widget get showErrorWidget {
    switch (this) {
      case CustomExceptionType.cannotReachServer:
        return const Icon(Icons.cloud_off_rounded);
      case CustomExceptionType.noNetwork:
        return const Icon(Icons.wifi_off_rounded);
      case CustomExceptionType.somethingWentWrong:
        return const Icon(Icons.error_outline_rounded);
      case CustomExceptionType.invalidUrl:
        return const Icon(Icons.link_off_rounded);
      case CustomExceptionType.internalServerError:
        return const Icon(Icons.cloud_off_rounded);
    }
  }
}

class CustomException implements Exception {
  final dynamic message;
  final int? statusCode;

  CustomException(this.message, {this.statusCode});

  @override
  String toString() {
    return message.toString();
  }
}

dynamic handleError(dynamic exception) {
  switch (exception.runtimeType) {
    case const (DioException):
      dynamic message = CustomExceptionType.somethingWentWrong;
      final dioException = exception as DioException;
      switch (dioException.type) {
        case DioExceptionType.connectionError:
          if (dioException.error is SocketException) {
            if ([61, 64, 8].contains(
              (dioException.error as SocketException).osError?.errorCode,
            )) {
              message = CustomExceptionType.cannotReachServer;
            } else if ([101].contains(
              (dioException.error as SocketException).osError?.errorCode,
            )) {
              message = CustomExceptionType.noNetwork;
            }
          }

          exception = CustomException(message);
          break;
        case DioExceptionType.connectionTimeout:
          message = CustomExceptionType.somethingWentWrong;
          exception = CustomException(message);
          break;
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.unknown:
          if (dioException.error is HandshakeException) {
            exception = CustomException(
              (dioException.error as HandshakeException).message,
            );
          }
          break;
        case DioExceptionType.badCertificate:
          break;
        case DioExceptionType.badResponse:
          var data = dioException.response?.data;

          if (dioException.response?.statusCode == 500) {
            message = CustomExceptionType.internalServerError;
          } else if (data is Map) {
            if (data['message'] != null) {
              message = data['message'];
            } else if (data['error'] != null) {
              if (data['error'] is Map && data['error']['message'] != null) {
                message = data['error']['message'];
              } else {
                message = data['error'].toString();
              }
            } else {
              message = CustomExceptionType.somethingWentWrong;
            }
          } else {
            message = CustomExceptionType.internalServerError;
          }
          exception = CustomException(
            message,
            statusCode: dioException.response?.statusCode,
          );
          break;
      }
    default:
      exception = CustomException(exception.toString());
  }
  return exception;
}
