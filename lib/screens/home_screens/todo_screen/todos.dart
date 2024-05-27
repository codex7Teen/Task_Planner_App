
import 'package:flutter/material.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/db/model/todo_steps_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';

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
      physics: const NeverScrollableScrollPhysics(),
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
                  const Icon(Icons.circle, color: whiteColor, size: 10),
                  const SizedBox(width: 8),
                  Text(todoData.stepTodo,
                      style: todoData.isTodoChecked ? Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey[600], decoration: TextDecoration.lineThrough) : Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: whiteColor)
                          ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      checkColor: const Color.fromARGB(255, 6, 0, 61),
                      fillColor: const MaterialStatePropertyAll(whiteColor),
                      value: todoData.isTodoChecked,
                      onChanged: (newBool) {
                        setState(() {
                          todoData.isTodoChecked = newBool ?? false;

                        
                          // assigning to newlychanged bool to isTodoChecked inside todostepsmodel which is inside todoModel
                          todo.todoStepsList[index].isTodoChecked = todoData.isTodoChecked;
                          // save to db (todomodel)
                          TodoFunctions().updateTodo(todo.key!, todo);
                        });
                      }),
                  IconButton(
                      onPressed: ()async {
                        // delete step
                        todo.todoStepsList.removeAt(index);
                        await TodoFunctions().updateTodo(todo.key, todo);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: whiteColor,
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
