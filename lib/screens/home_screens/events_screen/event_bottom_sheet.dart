// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_utils.dart';
import 'package:scribe/screens/validations/snackbar.dart';
import 'package:scribe/screens/validations/validations.dart';

// creating a global key for forms
final _formKey = GlobalKey<FormState>();

// event name controller
final eventNameController = TextEditingController();

late DateTime fromDate;

late DateTime toDate; 

eventBottomSheet(BuildContext context) {

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
                                          ?.copyWith(
                                              color: Colors.white, fontSize: 17),
                        decoration: InputDecoration(
                            label: Text(
                              'Enter event name',
                              style: Theme.of(context)
                              .textTheme
                              .titleSmall?.copyWith(color: Colors.grey)
                            ),
                            border: InputBorder.none),
                      ))
                    ],
                  ),
                  Divider(),

                  SizedBox(height: 30),

                  //! select from date & time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FROM', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontSize: 16)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                              // getting date from calendar utils
                              leading: Text(Utils.toDate(fromDate), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
                              trailing: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white,),
                              onTap: () {
                                // open select from date
                                
                              },
                            ),
                          ),

                         Expanded(
                            child: ListTile(
                              leading: Text(Utils.toTime(fromDate), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
                              trailing: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white,),
                              onTap: () {
                                // open select from time
                                
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  SizedBox(height: 30),

                   //! select to date & time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TO', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontSize: 16)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                              // getting date from calendar utils
                              leading: Text(Utils.toDate(toDate), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
                              trailing: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white,),
                              onTap: () {
                                // open select from date
                              },
                            ),
                          ),

                         Expanded(
                            child: ListTile(
                              leading: Text(Utils.toTime(toDate), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
                              trailing: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white,),
                              onTap: () {
                                // open select from time
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  SizedBox(height: 35),

                  //! Create button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // create-button
                      GestureDetector(
                        onTap: () {
                          // checking validation on button click
                          if (_formKey.currentState!.validate()) {
                            // popping bottomsheet
                            Navigator.pop(context);
                            // snackbar
                            showSnackBar(context, 'Event added successfully.');
                            // clear the fields
                            eventNameController.clear();
                          }
                          
                          // save datas to database

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
                                Text(
                                  'Create',
                                  style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19)
                                ),
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
