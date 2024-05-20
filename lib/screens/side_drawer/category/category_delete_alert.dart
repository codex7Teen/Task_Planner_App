// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';

// ! Delete Alert Box
showCategoryAlertDialog(BuildContext context, int? id) {
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
                    deleteCategory(id);
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