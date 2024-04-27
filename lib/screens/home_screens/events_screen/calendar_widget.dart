// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(

        // giving curve to edges of calendar
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15), 
          child: SfCalendar(
            view: CalendarView.month,
            initialSelectedDate: DateTime.now(),
            backgroundColor: Colors.white,
            cellBorderColor: Color.fromARGB(255, 221, 235, 255),
          
            // calendar header style
            headerStyle: CalendarHeaderStyle(
                backgroundColor: Color.fromARGB(255, 6, 0, 61),
                textAlign: TextAlign.center,
                textStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
            todayHighlightColor: Color.fromARGB(255, 6, 0, 61),
            selectionDecoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Color.fromARGB(255, 6, 0, 61),
              ),
            ),
            headerHeight: 50,
          
            // weeddays textstyle (sun, mon etc..)
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: Color.fromARGB(255, 221, 235, 255)
            ),
          
            // Date numbers (1, 2 , 3 etc..)
           monthViewSettings: MonthViewSettings(
            monthCellStyle: MonthCellStyle(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 6, 0, 61),
                fontWeight: FontWeight.w500,
              ),
            ),
           ),
          
          ),
        ),
    );
  }
}
