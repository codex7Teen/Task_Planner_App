//! E V E N T - F U N C T I O N S
  import 'package:flutter/material.dart';
import 'package:scribe/decorators/colors/app_colors.dart';

Future<DateTime?> pickDateTime(
   BuildContext context,
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          // datepicker color-theme
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: blueColor, // header background color
                ),
              ),
              child: child!,
            );
          },
          context: context,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101),
          initialDate: initialDate);

      if (date == null) return null;
      // assigns the initial time to time
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          // timepicker color-theme
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                    primary: blueColor, // header background color
                    secondary: cyanColor),
              ),
              child: child!,
            );
          },
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  //! F R O M - DATE-TIME
  Future pickFromDateTime( BuildContext context,
  ValueNotifier<DateTime> fromDateNotifier,
  ValueNotifier<DateTime> toDateNotifier,{required bool pickDate}) async {
    final date = await pickDateTime(context, fromDateNotifier.value, pickDate: pickDate);

    if (date == null) return;

    // setting the todate to same as fromdate if selected fromdate is after the todate
    if (date.isAfter(toDateNotifier.value)) {
      // Update toDateNotifier with combined DateTime
      toDateNotifier.value = date.add(const Duration(hours: 2));
    }

    // adding the from datetime to notifier obj
    fromDateNotifier.value = date;
  }

  //! T O - DATE-TIME
  Future pickToDateTime( BuildContext context,
  ValueNotifier<DateTime> fromDateNotifier,
  ValueNotifier<DateTime> toDateNotifier,{required bool pickDate}) async {
    final date = await pickDateTime(
      context,
      toDateNotifier.value,
      pickDate: pickDate,
      firstDate: pickDate ? fromDateNotifier.value : null,
    );

    if (date == null) return;

    // adding the from datetime to notifier obj
    toDateNotifier.value = date;

     // Ensure toDate is always 2 hours after fromDate
  toDateNotifier.value = date.isBefore(fromDateNotifier.value)
      ? fromDateNotifier.value.add(const Duration(hours: 2))
      : date;
  }