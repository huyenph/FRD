import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final logger = Logger(
    printer: PrettyPrinter(colors: true, printEmojis: true),
    output: ConsoleOutput(),
  );
}

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      if (kDebugMode) {
        print(line);
      }
    }
  }
}
