import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hpcompose/common/app_colors.dart';
import 'package:hpcompose/modules/events/domain/models/event.dart';
import 'package:hpcompose/presentation/base/base_ui.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends BaseState<EventScreen> {
  @override
  Widget buildBody(BuildContext context) {
    return SfCalendar(
      view: CalendarView.schedule,
      dataSource: MeetingDataSource(_getDataSource()),
      monthViewSettings: const MonthViewSettings(
        showAgenda: true,
        appointmentDisplayMode: MonthAppointmentDisplayMode.none,
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;

  List<Event> _getDataSource() {
    final List<Event> meetings = <Event>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Event(
      id: Random().toString(),
      eventName: 'Event 1',
      from: startTime,
      to: endTime,
      background: AppColors.cardDarkColor,
      isAllDay: false,
    ));
    meetings.add(Event(
      id: Random().toString(),
      eventName: 'Event 1',
      from: DateTime(today.year, today.month, today.day + 1, 9),
      to: endTime,
      background: AppColors.cardDarkColor,
      isAllDay: false,
    ));
    meetings.add(Event(
      id: Random().toString(),
      eventName: 'Event 1',
      from: DateTime(today.year, today.month, today.day + 2, 9),
      to: endTime,
      background: AppColors.cardDarkColor,
      isAllDay: false,
    ));
    meetings.add(Event(
      id: Random().toString(),
      eventName: 'Event 1',
      from: DateTime(today.year, today.month, today.day + 3, 9),
      to: endTime,
      background: AppColors.cardDarkColor,
      isAllDay: false,
    ));
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Event _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Event meetingData;
    if (meeting is Event) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
