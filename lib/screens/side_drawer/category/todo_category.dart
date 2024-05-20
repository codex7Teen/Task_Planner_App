// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/screens/home_screens/todo_screen/add_todo_pop.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo,s.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_alert_box.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_edit_bottom_sheet.dart';

class TodoCategory extends StatefulWidget {
  const TodoCategory({super.key});

  @override
  State<TodoCategory> createState() => _TodoCategoryState();
}

class _TodoCategoryState extends State<TodoCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 150, bottom: 35),
      child: Expanded(
        child: ValueListenableBuilder(
            valueListenable: todoListNotifier,
            builder:
                (BuildContext context, List<TodoModel> todoList, Widget? child) {
              // showing add any task gif
              if (todoListNotifier.value.isEmpty) {
                return Column(
                  children: [
                    SizedBox(height: 109),
                    Lottie.asset('assets/animations/todo.json', width: 290),
                    Text('Add your todo,s...',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w300, fontSize: 24))
                  ],
                );
              } else {
                // displaying the todos
                return ListView.separated(
                    itemBuilder: (context, index) {
                      final data = todoList[index];
      
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ExpansionTile(
                          collapsedBackgroundColor:
                              Color.fromARGB(255, 221, 235, 255),
                          shape: Border(),
                          title: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 6, 0, 61),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Checkbox(
                                    fillColor:
                                        MaterialStatePropertyAll(Colors.white),
                                    checkColor: Color.fromARGB(255, 6, 0, 61),
                                    value: data.todoCheckBox,
                                    onChanged: (newBool) {
                                      setState(() {
                                        data.todoCheckBox = newBool ?? false;
                                      });
                                    }),
                                SizedBox(width: 5),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    // to-do name
                                    child: Text(data.name,
                                        style: data.todoCheckBox
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 17,
                                                    decoration: TextDecoration
                                                        .lineThrough)
                                            : Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 17)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 6, 0, 61),
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.3,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //! STEPS  &  C H E C K B O X E S
                                    TodoWidget(todoModel: data),
      
                                    SizedBox(height: 10),
      
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
                                              // ADD STEPS (Opens add step popup)
                                              showAddTodoPopup(context, data);
                                            },
                                            icon: Icon(
                                              Icons.add_task_rounded,
                                              color: Colors.white,
                                              size: 23,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              // edit todos
                                              todoEditBottomSheet(
                                                  context, data.name, data);
                                            },
                                            icon: Icon(
                                              Icons.edit_note_rounded,
                                              color: Colors.white,
                                              size: 30,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                data.todoFavorite =
                                                    !data.todoFavorite;
                                                // save to db
                                                updateTodo(data.id!, data);
                                              });
                                            },
                                            icon: Icon(
                                                data.todoFavorite
                                                    ? Icons.favorite_rounded
                                                    : Icons
                                                        .favorite_border_rounded,
                                                color: Colors.white,
                                                size: 23)),
                                        IconButton(
                                            onPressed: () {
                                              // show delete alert-box
                                              showTodoAlertDialog(
                                                  context, data.id);
                                            },
                                            icon: Icon(
                                                Icons.delete_outline_rounded,
                                                color: Colors.white,
                                                size: 23)),
                                        SizedBox(
                                          width: 24,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: todoList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 18);
                    });
              }
            }),
      ),
    );
  }
}
