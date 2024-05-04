// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/db/model/task_steps_model.dart';

class StepsWidget extends StatefulWidget {
  final TaskModel taskModel;
  const StepsWidget({super.key, required this.taskModel});

  @override
  State<StepsWidget> createState() => _StepsWidgetState();
}

class _StepsWidgetState extends State<StepsWidget> {
  // steps checkbox
  bool? isChecked2 = false;
  
  late TaskModel task;
  late List<TaskStepsModel> stepsDataList;

  @override
  void initState() {
    stepsDataList = widget.taskModel.taskStepsList;
    task = widget.taskModel;
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
        final stepsData = stepsDataList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.white, size: 10),
                  SizedBox(width: 8),
                  Text(stepsData.step,
                      style: stepsData.isChecked ? Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white, decoration: TextDecoration.lineThrough) :Theme.of(context)
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
                      value: isChecked2,
                      onChanged: (newBool) {
                        setState(() {
                          isChecked2 = newBool;  
                        });
                      }),
                  IconButton(
                      onPressed: ()async {
                        // delete step
                        task.taskStepsList.removeAt(index); 
                       await updateTask(task.key, task);
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
      itemCount: stepsDataList.length,
    );
  }
}
