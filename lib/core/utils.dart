import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

double fixed(double value, int decimal) {
  num fac = pow(10, decimal);
  return (value * fac).round() / fac;
}

bool useMobileLayout(BuildContext context) {
  double shortestSide = MediaQuery.sizeOf(context).shortestSide;
  return shortestSide < 600.0;
}

String timeFormat(String time) {
  return DateFormat('hh:mm a').format(DateTime.parse(time));
}

String dateFormat(String? date) {
  if (date == null) return 'dd/MM/yyyy';
  return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
}

String dateFormatEEEMMM(String date) {
  final DateTime time = DateTime.parse(date);
  final DateFormat dateFormat = DateFormat('EEE - MMM d,yyyy');
  return dateFormat.format(time.toLocal());
}

String getTimeNowWithFormat() {
  final DateFormat dateFormat = DateFormat('d MMM yyy, hh:mm a');
  return dateFormat.format(DateTime.now().toLocal());
}

int calculateTimeYearsOld(String? dob) {
  if (dob == null || dob.isEmpty) {
    return 0;
  }
  final DateTime timeDOB = DateTime.parse(dob);
  final DateTime timeNow = DateTime.now();
  final int yearsOld = timeNow.difference(timeDOB).inDays ~/ 365;
  return yearsOld;
}

String getFileSizeString(
    {required int bytes, int decimals = 0, int maxSize = 50}) {
  const suffixes = ["B", "Kb", "Mb", "Gb", "Tb"];
  if (bytes == 0) return '0 ${suffixes[0]}';
  var i = (log(bytes) / log(1024)).floor();
  double size = bytes / pow(1024, i);
  if (i >= 2 && size > maxSize) {
    throw PlatformException(code: 'file_picker_max_size');
  } else {
    return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

// // Size measureWidget(Widget widget) {
// //   final PipelineOwner pipelineOwner = PipelineOwner();
// //   final MeasurementView rootView = pipelineOwner.rootNode = MeasurementView();
// //   final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
// //   final RenderObjectToWidgetElement<RenderBox> element =
// //       RenderObjectToWidgetAdapter<RenderBox>(
// //     container: rootView,
// //     debugShortDescription: '[root]',
// //     child: widget,
// //   ).attachToRenderTree(buildOwner);
// //   try {
// //     rootView.scheduleInitialLayout();
// //     pipelineOwner.flushLayout();
// //     return rootView.size;
// //   } finally {
// //     // Clean up.
// //     element.update(RenderObjectToWidgetAdapter<RenderBox>(container: rootView));
// //     buildOwner.finalizeTree();
// //   }
// }
