// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/model/task_model.dart';

class SearchBarField extends StatefulWidget {
  final VoidCallback onCancelTapped;
  final List<TaskModel> taskListx;
  const SearchBarField(
      {super.key, required this.onCancelTapped, required this.taskListx});

  @override
  State<SearchBarField> createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends State<SearchBarField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 11),
      child: TextFormField(
        onChanged: (value) {
          searchFields(value);
        },
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Color.fromARGB(255, 6, 0, 61)),
        decoration: InputDecoration(
            hintText: 'Search...',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            suffixIcon: IconButton(
                onPressed: () {
                  // clear field
                  clearSearchField();
                  // toggle between icons.
                  widget.onCancelTapped();
                },
                icon: Icon(Icons.cancel_rounded)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 25, vertical: 12.0)),
      ),
    );
  }

  // method for searching tasks
  void searchFields(String query) {
    List<TaskModel> filteredTasks = widget.taskListx.where((list) {
      return list.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      // assisgning the filtered tasks to taskmodel
      taskListNotifier.value = filteredTasks;
    });
  }

  // clear the textformfield value on cancel button tap
  void clearSearchField() {
    searchFields('');
  }
}
