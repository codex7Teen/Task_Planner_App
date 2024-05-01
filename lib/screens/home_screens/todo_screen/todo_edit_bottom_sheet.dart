// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/screens/validations/snackbar.dart';
import 'package:scribe/screens/validations/validations.dart';

// creating a global key for forms
final _formKey = GlobalKey<FormState>();

// to-do name controller
final nameController = TextEditingController();

todoEditBottomSheet(BuildContext context, String initialTodoName, TodoModel todoModel) {
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
                  // Enter task field
                  Row(
                    children: [
                      Icon(Icons.task_alt_rounded,
                          color: Colors.white, size: 23),
                      SizedBox(width: 25),
                      Expanded(
                          child: TextFormField(
                        controller: nameController..text = initialTodoName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) => Validators()
                            .validateField(name, 'Please enter todo name'),
                        style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: Colors.white, fontSize: 17),
                        decoration: InputDecoration(
                            label: Text(
                              'Enter todo name',
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
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ));
                            }).toList()),
                      ),

                      // create-button
                      GestureDetector(
                        onTap: () {
                          // checking validation on button click
                          if (_formKey.currentState!.validate()) {
                            // popping bottomsheet
                            Navigator.pop(context);
                            // snackbar
                            showSnackBar(context, 'Todo updated successfully.');
                          }

                          // save datas to database
                          final newTodoName = nameController.text.trim();

                          if (newTodoName.isNotEmpty) {
                            // add to model
                            todoModel.name = newTodoName;
                            // add to db
                            updateTodo(todoModel.id!, todoModel);
                          }
                        },
                        child: Container(
                          height: 35,
                          width: 105,
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
                                  'Update',
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
