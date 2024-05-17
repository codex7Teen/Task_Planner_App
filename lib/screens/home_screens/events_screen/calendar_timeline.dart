// Filtering dates upon the date pressed and hold
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/event_db_functions.dart';
import 'package:scribe/db/model/events_model.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Filtering events to show
List<EventsModel> _filterEventsByDate(DateTime date) {
  return eventListNotifier.value
      .where((event) =>
          event.from.day == date.day &&
          event.from.month == date.month &&
          event.from.year == date.year)
      .toList();
}

// Function to show bottom sheet with filtered events
void showTimelineBottomSheet(BuildContext context, DateTime date) {
  final filteredEvents = _filterEventsByDate(date);
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return filteredEvents.isEmpty
          ? Center(child: Text('No Events for this date'))
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SfCalendar(
                //! DECORATE
                backgroundColor: Colors.white,
                todayHighlightColor: Colors.black,
                cellBorderColor: Color.fromARGB(47, 221, 235, 255),
                timeSlotViewSettings: TimeSlotViewSettings(
                  timeTextStyle: Theme.of(context).textTheme.labelMedium,
                ),
                headerStyle: CalendarHeaderStyle(
                  backgroundColor: Color.fromARGB(255, 6, 0, 61),
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                view: CalendarView.timelineDay,

                dataSource: EventDataSource(filteredEvents),
                initialDisplayDate: date,
                appointmentBuilder: (context, details) {
                  final event = details.appointments.first as EventsModel;
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)),
                    width: details.bounds.width,
                    height: details.bounds.height,
                    child: Center(
                      child: Text(
                        event.name,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  );
                },
              ),
            );
    },
  );
}
