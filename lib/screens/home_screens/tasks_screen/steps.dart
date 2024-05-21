
import 'package:flutter/material.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/db/model/task_steps_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';

class StepsWidget extends StatefulWidget {
  final TaskModel taskModel;
  const StepsWidget({super.key, required this.taskModel});

  @override
  State<StepsWidget> createState() => _StepsWidgetState();
}

class _StepsWidgetState extends State<StepsWidget> {
  
  late TaskModel task;
  late List<TaskStepsModel> stepsDataList;

  @override
  void initState() {
    // getting List of taskstepsmodel
    stepsDataList = widget.taskModel.taskStepsList;
    // getting taskmodel
    task = widget.taskModel;
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
        final stepsData = stepsDataList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   stepsData.isStepChecked ? Icon(Icons.circle, color: Colors.grey[600], size: 10) : const Icon(Icons.circle, color: Color.fromARGB(255, 221, 235, 255), size: 10),
                  const SizedBox(width: 8),
                  Text(stepsData.step,
                      style: stepsData.isStepChecked ? Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey[600], decoration: TextDecoration.lineThrough) : Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: whiteColor))
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      checkColor: navyBlue1,
                      fillColor: const MaterialStatePropertyAll(whiteColor),
                      value: stepsData.isStepChecked,
                      onChanged: (newBool) {
                        setState(() {
                          stepsData.isStepChecked = newBool ?? false;

                          // assigning the new changed bool to isStepChecked bool inside taskstepsmodel
                          task.taskStepsList[index].isStepChecked = stepsData.isStepChecked;
                          // Save to taskstepsmodel
                          TaskFunctions().updateTask(task.key, task);
                        });
                      }),
                  IconButton(
                      onPressed: ()async {
                        // delete step
                        task.taskStepsList.removeAt(index); 
                       await TaskFunctions().updateTask(task.key, task); 
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
      itemCount: stepsDataList.length,
    );
  }
}
