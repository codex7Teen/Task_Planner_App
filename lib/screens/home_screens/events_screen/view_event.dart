// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/functions/event_db_functions.dart';
import 'package:scribe/db/functions/login_db_functions.dart';
import 'package:scribe/db/model/events_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_utils.dart';
import 'package:scribe/screens/home_screens/events_screen/edit_event_bottom_sheet.dart';
import 'package:scribe/screens/home_screens/events_screen/event_delete_alert.dart';
import 'package:scribe/screens/validations/validations.dart';

class ScreenViewEvent extends StatefulWidget {
  final EventsModel event;
  const ScreenViewEvent({super.key, required this.event});

  @override
  State<ScreenViewEvent> createState() => _ScreenViewEventState();
}

class _ScreenViewEventState extends State<ScreenViewEvent> {
  // setting globalkey for forms
  final _formKey = GlobalKey<FormState>();

// controller for description
  final TextEditingController eventDescriptionController =
      TextEditingController();

  // Store the original description
  String originalDescription = '';
  late EventsModel events;
  @override
  void initState() {
    super.initState();
    eventDescriptionController.text = widget.event.description ?? "";
    // Save original
    originalDescription = widget.event.description ?? "";
    events = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    // savebutton visibility
    bool showSaveButton =
        originalDescription != eventDescriptionController.text;

    return Scaffold(
      //! A P P - B A R
      appBar: AppBar(
        backgroundColor: navyBlue1,
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // notes title
            child: Text(events.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: whiteColor, fontSize: 20))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: whiteColor),
          onPressed: () {
            Navigator.pop(context, events);
          },
        ),
        actions: [
          //!  E D I T - E V E N T
          TextButton(
              onPressed: () {
                // fetch username from the loginListNotifier
                final userName = loginListNotifier.value[0].name;
                // Edit event (open edit-event bottomsheet)
                editEventBottomSheet(
                        context,
                        ValueNotifier<DateTime>(widget.event.from),
                        ValueNotifier<DateTime>(widget.event.to),
                        widget.event,
                        userName)
                    .then((value) {
                  setState(() {
                    events = value!;
                  });
                });
              },
              child: Text('Edit',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: whiteColor))),

          // Delete button
          TextButton(
              onPressed: () {
                // show alertbox and then delete event
                showEventlAertDialog(context, events.key);
              },
              child: Text('Delete',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: whiteColor))),
        ],
      ),
      backgroundColor: whiteColor,

      //! B O D Y
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! F R O M
              Row(
                children: [
                  Text('FROM',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: navyBlue1)),
                  const Spacer(),
                  Text(
                    // from date
                    Utils.toDate(events.from),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 25),
                  Text(
                    // from time
                    Utils.toTime(events.from),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              ),

              const SizedBox(height: 20),

              //! T O
              Row(
                children: [
                  Text('TO',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: navyBlue1)),
                  const Spacer(),
                  Text(
                    // to date
                    Utils.toDate(events.to),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    // to time
                    Utils.toTime(events.to),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              ),

              const SizedBox(height: 26),

              const Divider(),

              const SizedBox(height: 26),

              //! T I T L E
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(events.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 22, fontWeight: FontWeight.w500)),
              ),

              const SizedBox(height: 20),

              //! EVENT DESCRIPTION CONTAINER
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 235, 255),
                    borderRadius: BorderRadius.circular(20)),
                //! D E S C R I P T I O N - FIELD
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * .2,
                        maxHeight: MediaQuery.of(context).size.height * .6,
                      ),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => Validators().validateField(
                            value, 'Please write a description to save.'),
                        controller: eventDescriptionController,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            hintText: 'Write your event description...',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey[700]),
                            border: InputBorder.none),
                        maxLines: 30,
                        minLines: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      //! S A V E - B U T T O N
      floatingActionButton: showSaveButton
          ? Align(
              alignment: const Alignment(0.9, 0.95),
              child: FloatingActionButton.extended(
                backgroundColor: navyBlue1,
                label: Text(
                  'Save',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: whiteColor),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveAndUpdateEventDescription();
                    Navigator.pop(context);
                  }
                },
              ),
            )
          : null,
    );
  }

  // update and save description. method
  Future<void> saveAndUpdateEventDescription() async {
    final eventDB = await Hive.openBox<EventsModel>(EventsModel.boxName);
    // update note content
    widget.event.description = eventDescriptionController.text;
    // Save to hive
    await eventDB.put(widget.event.key, widget.event);
    // Call the Data saved snackbar
    // notify listeners
    eventListNotifier.notifyListeners();
  }
}
