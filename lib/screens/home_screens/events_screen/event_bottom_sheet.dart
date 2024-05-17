// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scribe/db/functions/event_db_functions.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/events_model.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_utils.dart';
import 'package:scribe/screens/validations/snackbar.dart';
import 'package:scribe/screens/validations/validations.dart';

// creating a global key for forms
final _formKey = GlobalKey<FormState>();

// event name controller
final eventNameController = TextEditingController();

eventBottomSheet(BuildContext context, ValueNotifier<DateTime> fromDateNotifier,
    ValueNotifier<DateTime> toDateNotifier) {
  //! E V E N T - F U N C T I O N S

  Future<DateTime?> pickDateTime(
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
                colorScheme: ColorScheme.light(
                  primary: Colors.blue, // header background color
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
                colorScheme: ColorScheme.light(
                    primary: Colors.blue, // header background color
                    secondary: Colors.cyan),
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
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDateNotifier.value, pickDate: pickDate);

    if (date == null) return;

    // setting the todate to same as fromdate if, selected fromdate is date after the to date
    if (date.isAfter(toDateNotifier.value)) {
      toDateNotifier.value = DateTime(date.year, date.month, date.day,
          fromDateNotifier.value.hour, fromDateNotifier.value.minute);
    }

    // adding the from datetime to notifier obj
    fromDateNotifier.value = date;
  }

  //! T O - DATE-TIME
  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDateNotifier.value, pickDate: pickDate,
    firstDate: pickDate ? fromDateNotifier.value : null,  
    );

    if (date == null) return;

    // adding the from datetime to notifier obj
    toDateNotifier.value = date;
  }

  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Color.fromARGB(255, 6, 0, 61),
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Enter event field
                  Row(
                    children: [
                      Icon(Icons.task_alt_rounded,
                          color: Colors.white, size: 23),
                      SizedBox(width: 25),
                      Expanded(
                          child: TextFormField(
                        controller: eventNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) => Validators()
                            .validateField(name, 'Please enter event name'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white, fontSize: 17),
                        decoration: InputDecoration(
                            label: Text('Enter event name',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.grey)),
                            border: InputBorder.none),
                      ))
                    ],
                  ),
                  Divider(),

                  SizedBox(height: 30),

                  //! select from date & time ( FROM )
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FROM',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.white, fontSize: 16)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                              // getting date
                              leading: ValueListenableBuilder(
                                  valueListenable: fromDateNotifier,
                                  builder: (context, value, _) {
                                    return Text(
                                        Utils.toDate(fromDateNotifier.value),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: Colors.white));
                                  }),
                              trailing: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // open select from date
                                pickFromDateTime(pickDate: true);
                              },
                            ),
                          ),
                          Expanded(
                            // getting time
                            child: ListTile(
                              leading: ValueListenableBuilder(
                                  valueListenable: fromDateNotifier,
                                  builder: (context, value, _) {
                                    return Text(
                                        Utils.toTime(fromDateNotifier.value),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: Colors.white));
                                  }),
                              trailing: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // open select from time
                                pickFromDateTime(pickDate: false);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  SizedBox(height: 30),

                  //! select to date & time ( TO )
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TO',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.white, fontSize: 16)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                              // getting date from calendar utils
                              leading: ValueListenableBuilder(
                                  valueListenable: toDateNotifier,
                                  builder: (context, value, _) {
                                    return Text(
                                        Utils.toDate(toDateNotifier.value),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: Colors.white));
                                  }),
                              trailing: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // open select from date
                                pickToDateTime(pickDate: true);
                              },
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              leading: ValueListenableBuilder(
                                  valueListenable: toDateNotifier,
                                  builder: (context, value, _) {
                                    return Text(
                                        Utils.toTime(toDateNotifier.value),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: Colors.white));
                                  }),
                              trailing: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // open select from time
                                pickToDateTime(pickDate: false);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  SizedBox(height: 35),

                  //! C R E A T E - B U T T O N
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // create-button
                      GestureDetector(
                        onTap: () {
                          // checking validation on button click
                          final validated = _formKey.currentState!.validate();
 
                          if (validated) {
                            // save datas to database
                            final eventName = eventNameController.text.trim();

                            final event = EventsModel(name: eventName, from: fromDateNotifier.value, to: toDateNotifier.value);

                            addEventDetails(event);

                            // popping bottomsheet
                            Navigator.pop(context);
                            // snackbar
                            showSnackBar(context, 'Event added successfully.');
                            // clear the fields
                            eventNameController.clear();
                          }

                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.5, color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 6, top: 3, left: 6, right: 6),
                            child: Row(
                              children: [
                                Icon(Icons.create_outlined,
                                    color: Colors.white, size: 18.5),
                                SizedBox(width: 6),
                                Text('Create',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
