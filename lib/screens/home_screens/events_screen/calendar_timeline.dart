// Filtering dates upon the date pressed and hold
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/event_db_functions.dart';
import 'package:scribe/db/model/events_model.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_data_source.dart';
import 'package:scribe/screens/home_screens/events_screen/view_event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Filtering events to show
List<EventsModel> _filterEventsByDate(DateTime date) {
  return eventListNotifier.value.where((event) {
    // Check if the selected date is within the event's date range
    return event.from.isBefore(date.add(Duration(days: 1))) &&
        event.to.isAfter(date.subtract(Duration(days: 1)));
  }).toList();
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
                //! DECORATION
                // secondary header
                backgroundColor: Colors.white,
                todayHighlightColor: Colors.black,
                cellBorderColor: Color.fromARGB(255, 221, 235, 255),
                timeSlotViewSettings: TimeSlotViewSettings(
                  timeTextStyle: Theme.of(context).textTheme.labelMedium,
                ),
                // primary header
                headerStyle: CalendarHeaderStyle(
                  backgroundColor: Color.fromARGB(255, 6, 0, 61),
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                viewHeaderStyle: ViewHeaderStyle(
                  backgroundColor: Color.fromARGB(255, 221, 235, 255),
                  dayTextStyle: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: 15),
                  dateTextStyle: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 6, 0, 61)),
                ),
                selectionDecoration:
                    BoxDecoration(color: Colors.blue.withOpacity(0.25)),
                view: CalendarView.timelineDay,

                //! DATAS
                dataSource: EventDataSource(filteredEvents),
                initialDisplayDate: date,
                appointmentBuilder: (context, details) {
                  final event = details.appointments.first as EventsModel;
                  return Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 221, 235, 255),
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
                // open the selected event in a new screen when user taps on particular event
                onTap: (calendarTapDetails) {
                  if (calendarTapDetails.targetElement ==
                          CalendarElement.appointment &&
                      calendarTapDetails.appointments != null &&
                      calendarTapDetails.appointments!.isNotEmpty) {
                    final event =
                        calendarTapDetails.appointments!.first as EventsModel;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScreenViewEvent(event: event)));
                  }
                },
              ),
            );
    },
  );
}
