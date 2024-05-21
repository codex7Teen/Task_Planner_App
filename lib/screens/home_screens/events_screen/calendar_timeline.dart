
import 'package:flutter/material.dart';
import 'package:scribe/db/functions/event_db_functions.dart';
import 'package:scribe/db/model/events_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_data_source.dart';
import 'package:scribe/screens/home_screens/events_screen/view_event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Filtering events to show
List<EventsModel> _filterEventsByDate(DateTime date) {
  return eventListNotifier.value.where((event) {
    // Check if the selected date is within the event's date range
    return event.from.isBefore(date.add(const Duration(days: 1))) &&
        event.to.isAfter(date.subtract(const Duration(days: 1)));
  }).toList();
}

// Function to show bottom sheet with filtered events
void showTimelineBottomSheet(BuildContext context, DateTime date) {
  var filteredEvents = _filterEventsByDate(date);

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return filteredEvents.isEmpty
          ? const Center(child: Text('No Events for this date'))
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // listens to date changes in the model
              child: ValueListenableBuilder(
                  valueListenable: eventListNotifier,
                  builder: (context, events, _) {
                    filteredEvents = _filterEventsByDate(date);

                    // Determine the initial display date to display the event directly while opening the SF Ca-timeline
                    DateTime initialDisplayDate = date;
                    if (filteredEvents.isNotEmpty) {
                      initialDisplayDate = filteredEvents.first.from;
                    }

                    return SfCalendar(
                      //! DECORATION
                      // secondary header
                      backgroundColor: whiteColor,
                      todayHighlightColor: blackColor,
                      cellBorderColor:  alertBackgroundColor,
                      timeSlotViewSettings: TimeSlotViewSettings(
                        timeTextStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                      // primary header
                      headerStyle: const CalendarHeaderStyle(
                        backgroundColor: navyBlue1,
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: whiteColor),
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                        backgroundColor: alertBackgroundColor,
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
                                color: navyBlue1),
                      ),
                      selectionDecoration:
                          BoxDecoration(color: Colors.blue.withOpacity(0.25)),
                      view: CalendarView.timelineDay,

                      //! DATAS
                      dataSource: EventDataSource(filteredEvents),
                      initialDisplayDate: initialDisplayDate,
                      appointmentBuilder: (context, details) {
                        final event = details.appointments.first as EventsModel;
                        return Container(
                          decoration: BoxDecoration(
                              color:  alertBackgroundColor,
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
                          final event = calendarTapDetails.appointments!.first
                              as EventsModel;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ScreenViewEvent(event: event)));
                        }
                      },
                    );
                  }),
            );
    },
  );
}
