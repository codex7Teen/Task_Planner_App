
import 'package:flutter/material.dart';
import 'package:scribe/db/functions/event_db_functions.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_data_source.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_timeline.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
//! INIT STATE
  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  // GETTING ALL EVENTS
  Future<void> _loadEvents() async {
    final allEvents = await EventFunctions().fetchEvents();
    eventListNotifier.value = allEvents;
    eventListNotifier.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(15), // Giving curve to edges of the calendar
        child: ValueListenableBuilder(
          valueListenable: eventListNotifier,
          builder: (context, events, _) {
            
            //  SHOW CALENDAR WITH DATA
            return SfCalendar(
              view: CalendarView.month,
              dataSource: EventDataSource(events), // Use custom data source
              initialSelectedDate: DateTime.now(),
              backgroundColor: whiteColor,
              cellBorderColor:  alertBackgroundColor,
              headerStyle: const CalendarHeaderStyle(
                backgroundColor: navyBlue1,
                textAlign: TextAlign.center,
                textStyle:
                    TextStyle(fontWeight: FontWeight.w500, color: whiteColor),
              ),
              todayHighlightColor:  navyBlue1,
              selectionDecoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: navyBlue1,
                ),
              ),
              headerHeight: 50,
              viewHeaderStyle: const ViewHeaderStyle(
                dayTextStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: alertBackgroundColor,
              ),
              monthViewSettings: const MonthViewSettings(
                monthCellStyle: MonthCellStyle(
                  textStyle: TextStyle(
                    color: navyBlue1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // open calendar timeline view when onlongpressed
              onLongPress: (details) {
                if (details.date != null) {
                  showTimelineBottomSheet(context, details.date!);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
