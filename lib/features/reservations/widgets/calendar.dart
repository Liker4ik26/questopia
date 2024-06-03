import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/common/utils/calendar_utils.dart';

@immutable
class TimeTableCalendar extends StatefulWidget {
  const TimeTableCalendar({
    Key? key,
    required this.onDaySelected,
    required this.chosenDate,
  }) : super(key: key);
  final void Function(DateTime, DateTime) onDaySelected;
  final DateTime chosenDate;

  @override
  State<TimeTableCalendar> createState() => _TimeTableCalendarState();
}

class _TimeTableCalendarState extends State<TimeTableCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime firstDay = CalendarUtils.getFirstSemesterDay();
  final lastDay = CalendarUtils.getLastSemesterDay();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.5),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 16,
            cornerSmoothing: 1,
          ),
        ),
        color: context.color.onSecondary,
      ),
      child: TableCalendar(
        rowHeight: 60,
        focusedDay: widget.chosenDate,
        startingDayOfWeek: StartingDayOfWeek.monday,
        firstDay: firstDay,
        lastDay: lastDay,
        weekendDays: const [DateTime.sunday],
        onDaySelected: widget.onDaySelected,
        // setState(() {
        //   widget.chosenDate = selectedDay;
        // });
        selectedDayPredicate: (day) => isSameDay(
          day,
          widget.chosenDate,
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, events) {
            return Container(
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 12,
                    cornerSmoothing: 1,
                  ),
                ),
                color: context.color.onTertiary.withOpacity(0.5),
              ),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 8),
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                day.day.toString(),
                style: context.text.rfDewiSemiBold20.copyWith(
                  color: context.color.primary,
                ),
              ),
            ).paddingSymmetric(horizontal: 4);
          },
          outsideBuilder: (context, day, events) {
            return Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 8),
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                day.day.toString(),
                style: context.text.rfDewiRegular24.copyWith(
                  color: context.color.primary.withOpacity(0.4),
                ),
              ),
            );
          },
          selectedBuilder: (context, day, events) {
            return Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 8),
              margin: const EdgeInsets.only(top: 8),
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 12,
                    cornerSmoothing: 1,
                  ),
                ),
                color: context.color.tertiary,
              ),
              child: Text(
                day.day.toString(),
                style: context.text.rfDewiRegular24.copyWith(
                  color: context.color.primary,
                ),
              ),
            ).paddingSymmetric(horizontal: 4);
          },
          todayBuilder: (context, day, events) {
            return Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 8),
              margin: const EdgeInsets.only(top: 8),
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 12,
                    cornerSmoothing: 1,
                  ),
                ),
                color: context.color.backgroundColor.withOpacity(0.5),
              ),
              child: Text(
                day.day.toString(),
                style: context.text.rfDewiRegular24.copyWith(
                  color: context.color.primary,
                ),
              ),
            ).paddingSymmetric(horizontal: 4);
          },
          dowBuilder: (context, day) {
            return Center(
              child: Text(
                DateFormat(
                  'E',
                  Localizations.localeOf(context).languageCode,
                ).format(day).capitalize!,
                style: context.text.rfDewiRegular12.copyWith(
                    color: isSameDay(
                  day,
                  widget.chosenDate,
                )
                        ? context.color.primary
                        : context.color.primary.withOpacity(0.4)),
              ),
            );
          },
        ),
        headerVisible: false,
        calendarFormat: _calendarFormat,
        formatAnimationDuration: const Duration(milliseconds: 400),
        formatAnimationCurve: Curves.easeInOut,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
          CalendarFormat.week: 'Week',
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        calendarStyle: const CalendarStyle(
          cellAlignment: Alignment.center,
          markersAlignment: Alignment.topCenter,
          tablePadding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: context.text.rfDewiRegular12,
        ),
      ),
    );
  }
}
