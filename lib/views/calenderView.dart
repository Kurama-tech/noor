import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  @override
  State createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SfCalendar(
          view: CalendarView.month,
          monthViewSettings: MonthViewSettings(showAgenda: true),
          monthCellBuilder: _monthCellBuilder,
          showDatePickerButton: true,
          showNavigationArrow: true,
        ),
      ),
    );
  }

  Widget _monthCellBuilder(
      BuildContext buildContext, MonthCellDetails details) {
    final bool isToday = DateTime.now().isSameDate(details.date);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.8, color: Colors.greenAccent),
          left: BorderSide(width: 0.8, color: Colors.greenAccent),
          //right: BorderSide(width: 0.8, color:Colors.greenAccent),
          //bottom: BorderSide(width: 0.8, color:Colors.greenAccent)
        ),
      ),
      child: Text(
        details.date.day.toString(),
        style: TextStyle(color: isToday ? Colors.amber : Colors.black),
      ),
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
