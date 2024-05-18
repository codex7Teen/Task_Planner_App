// ignore_for_file: prefer_const_constructors, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/functions/event_db_functions.dart';
import 'package:scribe/db/model/events_model.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_utils.dart';
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

  @override
  void initState() {
    super.initState();
    eventDescriptionController.text = widget.event.description ?? "";
    // Save original
    originalDescription = widget.event.description ?? ""; 
  }

  @override
  Widget build(BuildContext context) {

    // savebutton visibility
    bool showSaveButton = originalDescription != eventDescriptionController.text;


    return Scaffold(
      //! A P P - B A R
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 0, 61),
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // notes title
            child: Text(widget.event.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white, fontSize: 20))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          //  Edit button
          TextButton(
              onPressed: () {},
              child: Text('Edit',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white))),

          // Delete button
          TextButton(
              onPressed: () {
                // show alertbox and then delete
              },
              child: Text('Delete',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white))),
        ],
      ),
      backgroundColor: Colors.white,

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
                          color: Color.fromARGB(255, 6, 0, 61))),
                  Spacer(),
                  Text(
                    // from date
                    Utils.toDate(widget.event.from),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 25),
                  Text(
                    // from time
                    Utils.toTime(widget.event.from),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              ),

              SizedBox(height: 20),

              //! T O
              Row(
                children: [
                  Text('TO',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(255, 6, 0, 61))),
                  Spacer(),
                  Text(
                    // to date
                    Utils.toDate(widget.event.to),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 20),
                  Text(
                    // to time
                    Utils.toTime(widget.event.to),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              ),

              SizedBox(height: 26),

              Divider(),

              SizedBox(height: 26),

              //! T I T L E
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(widget.event.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 22, fontWeight: FontWeight.w500)),
              ),

              SizedBox(height: 20),

              //! EVENT DESCRIPTION CONTAINER
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 221, 235, 255),
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
                        style: TextStyle(fontSize: 18),
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
              alignment: Alignment(0.9, 0.95),
              child: FloatingActionButton.extended(
                backgroundColor: Color.fromARGB(255, 6, 0, 61),
                label: Text(
                  'Save',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.white),
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
    await eventDB.put(widget.event.id, widget.event);
    // Call the Data saved snackbar
    // notify listeners
    eventListNotifier.notifyListeners();
  }
}
