import 'package:flutter/material.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/decorators/colors/app_colors.dart';

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
                ?.copyWith(color: navyBlue1),
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
                    NotesFunctions().deleteNotes(id).then((value) {
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
                      ?.copyWith(color: navyBlue1),
                )),
          ],
          backgroundColor: alertBackgroundColor,
        );
      });
}
