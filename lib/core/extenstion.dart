import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  String? get dayMonthYear =>
      this == null ? null : DateFormat('dd/MM/yyyy').format(this!);

  String? get time => this == null ? null : DateFormat('hh:mma').format(this!);
}
