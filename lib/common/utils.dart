import 'package:logger/logger.dart';
import 'dart:math';

void appLogging() {
  Logger.level = Level.info;
  Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );
}

double fixed(double value, int decimal) {
  num fac = pow(10, decimal);
  return (value * fac).round() / fac;
}
