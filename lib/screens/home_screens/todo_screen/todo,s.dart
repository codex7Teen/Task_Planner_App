// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/db/model/todo_steps_model.dart';

class TodoWidget extends StatefulWidget {
  final TodoModel todoModel;
  const TodoWidget({super.key, required this.todoModel});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {

  late TodoModel todo;
  late List<TodoStepsModel> todoDataList;

  @override
  void initState() {
    // getting todomodel
    todo = widget.todoModel;
    // getting list of todostepsmodel
    todoDataList = widget.todoModel.todoStepsList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // making the list non scrollable
      physics: NeverScrollableScrollPhysics(),
      // shrinkwrap to use only the required size
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // getting datas from db
        final todoData = todoDataList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.white, size: 10),
                  SizedBox(width: 8),
                  Text(todoData.stepTodo,
                      style: todoData.isTodoChecked ? Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey[600], decoration: TextDecoration.lineThrough) : Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white)
                          ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      checkColor: Color.fromARGB(255, 6, 0, 61),
                      fillColor: MaterialStatePropertyAll(Colors.white),
                      value: todoData.isTodoChecked,
                      onChanged: (newBool) {
                        setState(() {
                          todoData.isTodoChecked = newBool ?? false;

                        
                          // assigning to newlychanged bool to isTodoChecked inside todostepsmodel which is inside todoModel
                          todo.todoStepsList[index].isTodoChecked = todoData.isTodoChecked;
                          // save to db (todomodel)
                          updateTodo(todo.id!, todo);
                        });
                      }),
                  IconButton(
                      onPressed: ()async {
                        // delete step
                        todo.todoStepsList.removeAt(index);
                        await updateTodo(todo.key, todo);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 23,
                      )),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: todoDataList.length,
    );
  }
}
