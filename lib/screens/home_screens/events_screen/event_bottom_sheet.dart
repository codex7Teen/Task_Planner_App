// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:scribe/screens/validations/snackbar.dart';
import 'package:scribe/screens/validations/validations.dart';

// creating a global key for forms
final _formKey = GlobalKey<FormState>();

// event name controller
final nameController = TextEditingController();

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
                        controller: nameController,
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

                  SizedBox(height: 35),

                  //! select date & time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Select date
                      Column(
                        children: [
                          Icon(Icons.calendar_month_outlined, color: Colors.white,size: 32,),
                          SizedBox(height: 7),
                          Text('Select Date', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white))
                        ],
                      ),

                      // Select time
                      Column(
                        children: [
                          Icon(Icons.timer_outlined, color: Colors.white,size: 32,),
                           SizedBox(height: 7),
                          Text('Select Time', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white))
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 35),

                  //! Dropdown list and create button
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
