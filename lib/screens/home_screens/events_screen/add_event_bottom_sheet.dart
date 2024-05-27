import 'package:flutter/material.dart';
import 'package:scribe/db/functions/event_db_functions.dart';
import 'package:scribe/db/model/events_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_utils.dart';
import 'package:scribe/screens/home_screens/events_screen/event_functions.dart';
import 'package:scribe/screens/home_screens/events_screen/notification_service.dart';
import 'package:scribe/screens/validations/snackbar.dart';
import 'package:scribe/screens/validations/validations.dart';

// creating a global key for forms
final _formKey = GlobalKey<FormState>();

// event name controller
final eventNameController = TextEditingController();

eventBottomSheet(BuildContext context, ValueNotifier<DateTime> fromDateNotifier,
    ValueNotifier<DateTime> toDateNotifier, String userName) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: navyBlue1,
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
                      const Icon(Icons.task_alt_rounded,
                          color: whiteColor, size: 23),
                      const SizedBox(width: 25),
                      Expanded(
                          child: TextFormField(
                        maxLength: 30,
                        controller: eventNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) => Validators()
                            .validateField(name, 'Please enter event name'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: whiteColor, fontSize: 17),
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
                  const Divider(),

                  const SizedBox(height: 30),

                  //! select from date & time ( FROM )
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FROM',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: whiteColor, fontSize: 16)),
                      const SizedBox(height: 8),
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
                                            .copyWith(color: whiteColor));
                                  }),
                              trailing: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: whiteColor,
                              ),
                              onTap: () {
                                // open select from date
                                pickFromDateTime(
                                    context, fromDateNotifier, toDateNotifier,
                                    pickDate: true);
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
                                            .copyWith(color: whiteColor));
                                  }),
                              trailing: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: whiteColor,
                              ),
                              onTap: () {
                                // open select from time
                                pickFromDateTime(
                                    context, fromDateNotifier, toDateNotifier,
                                    pickDate: false);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 30),

                  //! select to date & time ( TO )
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TO',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: whiteColor, fontSize: 16)),
                      const SizedBox(height: 8),
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
                                            .copyWith(color: whiteColor));
                                  }),
                              trailing: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: whiteColor,
                              ),
                              onTap: () {
                                // open select from date
                                pickToDateTime(
                                    context, fromDateNotifier, toDateNotifier,
                                    pickDate: true);
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
                                            .copyWith(color: whiteColor));
                                  }),
                              trailing: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: whiteColor,
                              ),
                              onTap: () {
                                // open select from time
                                pickToDateTime(
                                    context, fromDateNotifier, toDateNotifier,
                                    pickDate: false);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 35),

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
                            final notificationId = fromDateNotifier
                                .value.microsecondsSinceEpoch
                                .remainder(100000);

                            final event = EventsModel(
                                name: eventName,
                                from: fromDateNotifier.value,
                                to: toDateNotifier.value,
                                notificationId: notificationId);

                            EventFunctions().addEventDetails(event);

                            // create a notification for the event
                            NotificationService.scheduleNotification(
                                notificationId,
                                event.from,
                                eventName,
                                userName);

                            // resets the fromdate and todate to current date
                            fromDateNotifier.value = DateTime.now();
                            toDateNotifier.value =
                                DateTime.now().add(const Duration(hours: 2));

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
                          width: 110,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5, color: whiteColor),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 6, top: 3, left: 6, right: 6),
                            child: Row(
                              children: [
                                const Icon(Icons.create_outlined,
                                    color: whiteColor, size: 18.5),
                                const SizedBox(width: 6),
                                Text('Create',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: whiteColor,
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
