// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/screens/validations/snackbar.dart';
import 'package:scribe/screens/validations/validations.dart';

// Setting global key for formkey
final _formKey = GlobalKey<FormState>();

// task name controller
final nameController = TextEditingController();

// task description controller
final descriptionController = TextEditingController();

void updateTaskBottomSheet(BuildContext context, String initialTaskName,
    String initialTaskDescriptionName, TaskModel taskModel) {
  final categoryList = ['Personal', 'Trip plans', 'Vacation'];

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
                // E N T E R - T A S K
                Row(
                  children: [
                    Icon(Icons.task_alt_rounded, color: Colors.white, size: 23),
                    SizedBox(width: 25),
                    Expanded(
                      child: TextFormField(
                        maxLength: 30,
                        controller: nameController..text = initialTaskName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) => Validators()
                            .validateField(name, 'Please enter task name'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white, fontSize: 17),
                        decoration: InputDecoration(
                          label: Text('Enter task name',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.grey)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: 30),
                // E N T E R - D E S C R I P T I O N
                Row(
                  children: [
                    Icon(Icons.description_outlined,
                        color: Colors.white, size: 23),
                    SizedBox(width: 26),
                    Expanded(
                      child: TextFormField(
                        maxLength: 90,
                        controller: descriptionController
                          ..text = initialTaskDescriptionName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (desc) => Validators().validateField(
                            desc, 'Please enter task description'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          label: Text('Enter description',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.grey)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: 30),
                // Dropdown list and create button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: DropdownButtonFormField(
                        style: TextStyle(color: Colors.white),
                        dropdownColor: Colors.black,
                        icon: Icon(Icons.arrow_drop_down_rounded,
                            color: Colors.white, size: 25),
                        hint: Text(
                          'Select Category',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (value) {
                          // print(value);
                        },
                        items: categoryList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Color.fromARGB(255, 6, 0, 61))),
                          );
                        }).toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //checking validation on button click
                        if (_formKey.currentState!.validate()) {
                          // popping bottomsheet
                          Navigator.pop(context);
                          // snackbar
                          showSnackBar(context, 'Task updated successfully.');
                        }

                        //! save datas to database
                        final newTaskName = nameController.text.trim();
                        final newTaskDescription = descriptionController.text.trim();

                        if(newTaskName.isNotEmpty && newTaskDescription.isNotEmpty) {
                          // Update name in the model
                          taskModel.name = newTaskName; 
                          taskModel.description = newTaskDescription;
                          // Adding to db
                          updateTask(taskModel.id!, taskModel);
                        }

                        
                      },
                      child: Container(
                        height: 35,
                        width: 105,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5, color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 6, top: 3, left: 6, right: 6),
                          child: Row(
                            children: [
                              Icon(Icons.create_outlined,
                                  color: Colors.white, size: 18.5),
                              SizedBox(width: 6),
                              Text('Update',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
