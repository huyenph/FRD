import 'package:logger/logger.dart';

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
