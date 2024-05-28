import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/tasks_screen/add_steps_pop.dart';
import 'package:scribe/screens/home_screens/tasks_screen/alert_box.dart';
import 'package:scribe/screens/home_screens/tasks_screen/steps.dart';
import 'package:scribe/screens/home_screens/tasks_screen/task_update_bottom_sheet.dart';

class TasksCategory extends StatefulWidget {
  final String selectedCategory;
  const TasksCategory({super.key, required this.selectedCategory});

  @override
  State<TasksCategory> createState() => _TasksCategoryState();
}

class _TasksCategoryState extends State<TasksCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 150, bottom: 35),
      child: ValueListenableBuilder(
        // listening to data change
        valueListenable: taskListNotifier,
        builder: (BuildContext context, List<TaskModel> taskList, Widget? child) {
          //! F I L T E R I N G
          // filtering task based on category
          final filteredTasks = taskList
              .where((task) => task.taskCategory == widget.selectedCategory)
              .toList();

          // showing add-task GIF if no data to display.
          if (filteredTasks.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .1),
                  Lottie.asset('assets/animations/tasks.json', width: 240),
                  Text(
                    'Add your tasks...',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w300, fontSize: 24),
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final data = filteredTasks[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: ExpansionTile(
                    collapsedBackgroundColor: alertBackgroundColor,
                    shape: const Border(),
                    title: Container(
                      decoration: BoxDecoration(
                        color: navyBlue1,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          // T A S K - C H E C K B O X
                          Checkbox(
                            fillColor: const MaterialStatePropertyAll(whiteColor),
                            checkColor: navyBlue1,
                            value: data.isChecked1,
                            onChanged: (newBool) {
                              setState(() {
                                data.isChecked1 = newBool ?? false;

                                /// save to task model
                                TaskFunctions().updateTask(data.key!, data);
                              });
                            },
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              // task name
                              child: Text(
                                data.name,
                                style: data.isChecked1
                                    ? Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 17,
                                        decoration: TextDecoration.lineThrough,
                                      )
                                    : Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: whiteColor,
                                        fontSize: 17,
                                      ),
                              ),
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
                              // description
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: Text(
                                  data.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: whiteColor),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              //! STEPS  &  C H E C K B O X E S
                              StepsWidget(taskModel: data),

                              const SizedBox(height: 10),

                              //! B O T T O M - I C O N S
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(width: 24),
                                  // Add task-btn
                                  IconButton(
                                    onPressed: () {
                                      // ADD STEPS (Opens add step popup)
                                      showAddStepsPopup(context, data);
                                    },
                                    icon: const Icon(
                                      Icons.add_task_rounded,
                                      color: whiteColor,
                                      size: 23,
                                    ),
                                  ),
                                  // edit task btn
                                  IconButton(
                                    onPressed: () {
                                      // edit tasks
                                      updateTaskBottomSheet(
                                        context,
                                        data.name,
                                        data.description,
                                        data,
                                        data.taskCategory,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit_note_rounded,
                                      color: whiteColor,
                                      size: 30,
                                    ),
                                  ),
                                  // favorite button
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        data.isFavorite = !data.isFavorite;
                                        // save to db
                                        TaskFunctions().updateTask(data.key!, data);
                                      });
                                    },
                                    icon: Icon(
                                      data.isFavorite
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      color: whiteColor,
                                      size: 23,
                                    ),
                                  ),
                                  // delete-task button
                                  IconButton(
                                    onPressed: () {
                                      // show delete alert-box
                                      showTaskAlertDialog(context, data.key);
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: whiteColor,
                                      size: 23,
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: filteredTasks.length,
              // spacing between each container
              separatorBuilder: (context, index) {
                return const SizedBox(height: 23);
              },
            );
          }
        },
      ),
    );
  }
}
