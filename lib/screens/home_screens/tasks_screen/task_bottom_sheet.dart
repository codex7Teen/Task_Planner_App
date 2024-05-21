
import 'package:flutter/material.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/validations/snackbar.dart';
import 'package:scribe/screens/validations/validations.dart';

// Setting global key for formkey
final _formKey = GlobalKey<FormState>();

// task name controller
final nameController = TextEditingController();
 
// task description controller
final descriptionController = TextEditingController();

// selected category which is used to capture the state
String? selectedTaskCategory;

void taskBottomSheet(BuildContext context) {

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: navyBlue1,
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
                // E N T E R - T A S K
                Row(
                  children: [
                    const Icon(Icons.task_alt_rounded, color: whiteColor, size: 23),
                    const SizedBox(width: 25),
                    Expanded(
                      child: TextFormField(
                        maxLength: 30,
                        controller: nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) => Validators()
                            .validateField(name, 'Please enter task name'),
                        style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: whiteColor, fontSize: 17),
                        decoration: InputDecoration(
                          label: Text('Enter task name', style: Theme.of(context)
                              .textTheme
                              .titleSmall?.copyWith(color: Colors.grey)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 30),
                // E N T E R - D E S C R I P T I O N
                Row(
                  children: [
                    const Icon(Icons.description_outlined,
                        color: whiteColor, size: 23),
                    const SizedBox(width: 26),
                    Expanded(
                      child: TextFormField(
                        maxLength: 90,
                        controller: descriptionController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (desc) => Validators().validateField(
                            desc, 'Please enter task description'),
                        style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: whiteColor, fontSize: 17, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          label: Text('Enter description', style: Theme.of(context)
                              .textTheme
                              .titleSmall?.copyWith(color: Colors.grey)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 30),
                // Dropdown list and create button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ValueListenableBuilder(
                        valueListenable: categoryListNotifier,
                        builder: (context, categoriesList, _) {
                          return categoriesList.isNotEmpty ? DropdownButtonFormField(
                            style: const TextStyle(color: whiteColor),
                            dropdownColor: blackColor,
                            icon: const Icon(Icons.arrow_drop_down_rounded,
                                color: whiteColor, size: 25),
                            hint: const Text(
                              'Select Category',
                              style: TextStyle(color: Colors.grey),
                            ),
                            onChanged: (value) {
                              selectedTaskCategory = value;
                            },
                            items: categoriesList.map((cat) {
                              return DropdownMenuItem(
                                value: cat,
                                child: Text(cat, style: Theme.of(context)
                                  .textTheme
                                  .titleMedium?.copyWith(color: whiteColor)),
                              );
                            }).toList(),
                          ) : const SizedBox(width: 10,);
                        }
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //checking validation on button click
                        if (_formKey.currentState!.validate()) {
                          // popping bottomsheet
                          Navigator.pop(context);
                          // snackbar
                          showSnackBar(context, 'Task added successfully.');
                        }

                        //! save datas to database
                        final taskName = nameController.text.trim();
                        final taskDescription = descriptionController.text.trim();

                        if(taskName.isNotEmpty && taskDescription.isNotEmpty) {

                          final task = TaskModel(name: taskName, description: taskDescription, taskStepsList: [], taskCategory: selectedTaskCategory);
                          // calling the addTaskDtaikl function and passing the model
                          addTaskDetails(task);
                          // clearing the textfields
                          nameController.clear();
                          descriptionController.clear();
                        }

                      },
                      child: Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5, color: whiteColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 6, top: 3, left: 6, right: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.create_outlined,
                                  color: whiteColor, size: 18.5),
                              const SizedBox(width: 6),
                              Text('Create', style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: whiteColor, fontWeight: FontWeight.bold, fontSize: 19)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}