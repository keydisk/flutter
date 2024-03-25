import 'package:intl/intl.dart';

extension NumberFormatExtension on NumberFormat {

  String moneyFormat(int data) {

    return NumberFormat('###,###').format(data);
  }
}