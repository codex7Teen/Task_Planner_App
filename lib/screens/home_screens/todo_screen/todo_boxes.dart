import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/todo_screen/add_todo_pop.dart';
import 'package:scribe/screens/home_screens/todo_screen/todos.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_alert_box.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_update_bottomsheet.dart';

class TodoBoxes extends StatefulWidget {
  final int todoSectionIndex;
  final bool todoSearchToggler;
  const TodoBoxes(
      {super.key,
      required this.todoSectionIndex,
      required this.todoSearchToggler});

  @override
  State<TodoBoxes> createState() => _TodoBoxesState();
}

class _TodoBoxesState extends State<TodoBoxes> {
  // heading checkbox
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: todoListNotifier,
          builder:
              (BuildContext context, List<TodoModel> todoList, Widget? child) {
            // filtering todos based on favorites
            List<TodoModel> filteredTodos = [];
            //! F I L T E R I N G - T O D O S
            filteredTodos = widget.todoSectionIndex == 0
                ? todoList
                : todoList.where((todo) => todo.todoFavorite).toList();

            // displaying no todos found while searching if....
            if (filteredTodos.isEmpty &&
                todoListNotifier.value.isEmpty &&
                widget.todoSearchToggler) {
              return Center(
                  child: Text('No notes found...🔍',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 22)));
              // showing add any task gif
            } else if (filteredTodos.isEmpty &&
                (widget.todoSectionIndex == 0 ||
                    widget.todoSectionIndex == 1)) {
              return Column(
                children: [
                  const SizedBox(height: 50),
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
                    final data = filteredTodos[index];

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ExpansionTile(
                        collapsedBackgroundColor: alertBackgroundColor,
                        shape: const Border(),
                        title: Container(
                          decoration: BoxDecoration(
                              color: navyBlue1,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Checkbox(
                                  fillColor: const MaterialStatePropertyAll(
                                      whiteColor),
                                  checkColor: navyBlue1,
                                  value: data.todoCheckBox,
                                  onChanged: (newBool) {
                                    setState(() {
                                      data.todoCheckBox = newBool ?? false;
                                    });
                                  }),
                              const SizedBox(width: 5),
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
                                                  color: whiteColor,
                                                  fontSize: 17)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: navyBlue1,
                              borderRadius: BorderRadius.circular(19),
                              border: Border.all(
                                color: whiteColor,
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

                                  const SizedBox(height: 10),

                                  // bottom icons
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            // ADD STEPS (Opens add step popup)
                                            showAddTodoPopup(context, data);
                                          },
                                          icon: const Icon(
                                            Icons.add_task_rounded,
                                            color: whiteColor,
                                            size: 23,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            // edit todos
                                            todoEditBottomSheet(
                                                context,
                                                data.name,
                                                data,
                                                data.todoCategory);
                                          },
                                          icon: const Icon(
                                            Icons.edit_note_rounded,
                                            color: whiteColor,
                                            size: 30,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              data.todoFavorite =
                                                  !data.todoFavorite;
                                              // save to db
                                              TodoFunctions()
                                                  .updateTodo(data.key!, data);
                                            });
                                          },
                                          icon: Icon(
                                              data.todoFavorite
                                                  ? Icons.favorite_rounded
                                                  : Icons
                                                      .favorite_border_rounded,
                                              color: whiteColor,
                                              size: 23)),
                                      IconButton(
                                          onPressed: () {
                                            // show delete alert-box
                                            showTodoAlertDialog(
                                                context, data.key);
                                          },
                                          icon: const Icon(
                                              Icons.delete_outline_rounded,
                                              color: whiteColor,
                                              size: 23)),
                                      const SizedBox(
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
                  itemCount: filteredTodos.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 18);
                  });
            }
          }),
    );
  }
}
