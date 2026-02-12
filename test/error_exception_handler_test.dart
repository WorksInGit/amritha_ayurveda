import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:amritha_ayurveda/core/error_exception_handler.dart';

void main() {
  group('Error Exception Handler Tests', () {
    test('SocketException maps to CustomExceptionType.cannotReachServer', () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionError,
        error: const SocketException('test', osError: OSError('test', 61)),
      );

      final result = handleError(dioException);
      expect(result, isA<CustomException>());
      expect(
        (result as CustomException).message,
        CustomExceptionType.cannotReachServer,
      );
    });

    test('Unknown error maps to string', () {
      final exception = Exception('Unknown error');
      final result = handleError(exception);
      expect(result, isA<CustomException>());
      expect(result.toString(), 'Exception: Unknown error');
    });
  });
}
