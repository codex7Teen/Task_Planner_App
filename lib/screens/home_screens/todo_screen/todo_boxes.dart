// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/screens/home_screens/todo_screen/add_todo_pop.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo,s.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_alert_box.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_bottom_sheet.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_edit_bottom_sheet.dart';

class TodoBoxes extends StatefulWidget {
  const TodoBoxes({super.key});

  @override
  State<TodoBoxes> createState() => _TodoBoxesState();
}

class _TodoBoxesState extends State<TodoBoxes> {
  // heading checkbox
  bool? isChecked = false;

  // steps checkbox
  bool? isChecked2 = false;

  // fovorites
  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: todoListNotifier,
          builder:
              (BuildContext context, List<TodoModel> todoList, Widget? child) {
            return todoListNotifier.value.isEmpty
                ? Column(
                    children: [
                      SizedBox(height: 50),
                      Lottie.asset('assets/animations/todo.json', width: 290),
                      Text('Add your todo,s...',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 24))
                    ],
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final data = todoList[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 6, 0, 61),
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.3,
                          ),
                        ),

                        // Heading with button
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      fillColor: MaterialStatePropertyAll(
                                          Colors.white),
                                      checkColor: Color.fromARGB(255, 6, 0, 61),
                                      value: isChecked,
                                      onChanged: (newBool) {
                                        setState(() {
                                          isChecked = newBool;
                                        });
                                      }),
                                  SizedBox(width: 6),
                                  Text(data.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: Colors.white,
                                              fontSize: 17)),
                                ],
                              ),
                              SizedBox(height: 10),

                               //! TODOS  &  C H E C K B O X E S
                               TodoWidget(todoModel: data),

                              // bottom icons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 24,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        //! show add todo popup
                                        showAddTodoPopup(context, data);
                                      },
                                      icon: Icon(
                                        Icons.add_task_rounded,
                                        color: Colors.white,
                                        size: 23,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        // edit todo
                                        todoEditBottomSheet(context, data.name, data);
                                      },
                                      icon: Icon(
                                        Icons.edit_note_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          favorite = !favorite;
                                        });
                                      },
                                      icon: Icon(
                                          favorite
                                              ? Icons.favorite_border_rounded
                                              : Icons.favorite_rounded,
                                          color: Colors.white,
                                          size: 23)),
                                  IconButton(
                                      onPressed: () {
                                        // show delete alert-box
                                        showTodoAlertDialog(context, data.id);
                                      },
                                      icon: Icon(Icons.delete_outline_rounded,
                                          color: Colors.white, size: 23)),
                                  SizedBox(
                                    width: 24,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: todoList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 18);
                    });
          }),
    );
  }
}
