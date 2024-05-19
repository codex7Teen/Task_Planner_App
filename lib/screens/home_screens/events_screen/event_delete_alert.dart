// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/event_db_functions.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';

// ! Delete Alert Box
showEventlAertDialog(BuildContext context, int? id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            'Are you sure ?',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Color.fromARGB(255, 6, 0, 61)),
          ),
          actions: [
            // cancel button
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.labelLarge,
                )),

            // delete button
            TextButton(
                onPressed: () {
                  // delete
                  if (id != null) {
                    deleteEvent(id);
                    // pop alert box
                    Navigator.pop(context);
                    // pop view event screen
                    Navigator.pop(context);
                    // pop calendar timeline bottomsheet
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Delete',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Color.fromARGB(255, 6, 0, 61)),
                )),
          ],
          backgroundColor: Color.fromARGB(255, 221, 235, 255),
        );
      });
}
