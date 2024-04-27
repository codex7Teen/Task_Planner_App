// ignore_for_file: unnecessary_import, prefer_const_constructors, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/screens/home_screens/tasks_screen/add_steps_pop.dart';
import 'package:scribe/screens/home_screens/tasks_screen/alert_box.dart';
import 'package:scribe/screens/home_screens/tasks_screen/steps.dart';
import 'package:scribe/screens/home_screens/tasks_screen/task_bottom_sheet.dart';
import 'package:scribe/screens/home_screens/tasks_screen/task_update_bottom_sheet.dart';

class TaskBoxes extends StatefulWidget {
  const TaskBoxes({super.key});

  @override
  State<TaskBoxes> createState() => _TaskBoxesState();
}

class _TaskBoxesState extends State<TaskBoxes> {
  // heading checkbox
  bool? isChecked = false;

  // favorites
  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        // listening to data change
        valueListenable: taskListNotifier,
        builder:
            (BuildContext context, List<TaskModel> taskList, Widget? child) {
          // showing add any add-task GIF if no data to display.
          return taskListNotifier.value.isEmpty
              ? Center(
                  child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height *.045),
                    Lottie.asset('assets/animations/tasks.json', width: 240),
                    Text('Add your tasks...',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 24))
                  ],
                ))
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final data = taskList[index];
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
                                  value: isChecked,
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked = newBool;
                                    });
                                  }),
                              SizedBox(width: 5),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  // task name
                                  child: Text(
                                    data.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Colors.white, fontSize: 17),
                                  ),
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
                                  // description
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    child: Text(
                                      data.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  //! STEPS  &  C H E C K B O X E S
                                  StepsWidget(taskModel: data),

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
                                            showAddStepsPopup(context, data);
                                          },
                                          icon: Icon(
                                            Icons.add_task_rounded,
                                            color: Colors.white,
                                            size: 23,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            // edit tasks
                                            updateTaskBottomSheet(context, data.name, data.description, data);
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
                                                  ? Icons
                                                      .favorite_border_rounded
                                                  : Icons.favorite_rounded,
                                              color: Colors.white,
                                              size: 23)),
                                      IconButton(
                                          onPressed: () {
                                            // show delete alert-box
                                            showTaskAlertDialog(
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
                  itemCount: taskList.length,
                  // spacing between each container
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 23);
                  },
                );
        },
      ),
    );
  }
}
