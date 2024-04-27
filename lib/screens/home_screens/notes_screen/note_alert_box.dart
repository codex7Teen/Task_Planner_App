// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';

// ! Delete Alert Box
showNotelAertDialog(BuildContext context, int? id) {
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
            // delete button
            TextButton(
                onPressed: () {
                  // delete
                  if (id != null) {
                    deleteNotes(id).then((value) {
                      // pops both alert and edit-note
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text(
                  'Delete',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Color.fromARGB(255, 6, 0, 61)),
                )),
            // cancel button
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.labelLarge,
                ))
          ],
          backgroundColor: Color.fromARGB(255, 221, 235, 255),
        );
      });
}
