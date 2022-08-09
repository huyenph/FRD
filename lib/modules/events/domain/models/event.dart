import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';

class Event {
  Event({
    required this.id,
    required this.eventName,
    required this.from,
    required this.to,
    this.background = AppColors.cardLightColor,
    required this.isAllDay,
  });

  final String id;

  final String eventName;

  final DateTime from;

  final DateTime to;

  final Color background;

  final bool isAllDay;

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        eventName = json['eventName'],
        from = json['from'],
        to = json['to'],
        background = json['background'],
        isAllDay = json['isAllDay'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'eventName': eventName,
        'from': from,
        'to': to,
        'background': background,
        'isAllDay': isAllDay,
      };
}
