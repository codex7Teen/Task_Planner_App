import 'package:flutter/material.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/validations/snackbar.dart';
import 'package:scribe/screens/validations/validations.dart';

// creating a global key for forms
final _formKey = GlobalKey<FormState>();

// to-do name controller
final nameController = TextEditingController();

todoEditBottomSheet(BuildContext context, String initialTodoName,
    TodoModel todoModel, String? initialCategoryName) {

  // displaying the initial category name as selected if its not null
  // Reset selectedCategory initially
  String? selectedTodoCategory = initialCategoryName;

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
                  // Enter task field
                  Row(
                    children: [
                      const Icon(Icons.task_alt_rounded,
                          color: whiteColor, size: 23),
                      const SizedBox(width: 25),
                      Expanded(
                          child: TextFormField(
                            maxLength: 30,
                        controller: nameController..text = initialTodoName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) => Validators()
                            .validateField(name, 'Please enter todo name'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: whiteColor, fontSize: 17),
                        decoration: InputDecoration(
                            label: Text('Enter todo name',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.grey)),
                            border: InputBorder.none),
                      ))
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
                            // Ensure the selected category is part of the list
                             if (!categoriesList.contains(selectedTodoCategory)) {
                              selectedTodoCategory = null;
                            }
                            return categoriesList.isNotEmpty
                                ? DropdownButtonFormField(
                                  isExpanded: true,
                                  value: selectedTodoCategory,
                                    style: const TextStyle(color: whiteColor),
                                    dropdownColor: Colors.black,
                                    icon: const Icon(Icons.arrow_drop_down_rounded,
                                        color: whiteColor, size: 25),
                                    hint: const Text(
                                      'Select Category',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    onChanged: (value) {
                                      selectedTodoCategory = value;
                                    },
                                    items: categoriesList.map((cat) {
                                      return DropdownMenuItem(
                                        value: cat,
                                        child: Text(cat,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    color: whiteColor)),
                                      );
                                    }).toList(),
                                  )
                                : const SizedBox(
                                    width: 10,
                                  );
                          }),
                      ),

                      // create-button
                      GestureDetector(
                        onTap: () {
                          // checking validation on button click
                          if (_formKey.currentState!.validate()) {
                            // popping bottomsheet
                            Navigator.pop(context);
                            // snackbar
                            showSnackBar(context, 'Todo updated successfully.');
                          }

                          // save datas to database
                          final newTodoName = nameController.text.trim();

                          if (newTodoName.isNotEmpty) {
                            // add to db
                            todoModel.name = newTodoName;
                            // add to db
                            todoModel.todoCategory = selectedTodoCategory;
                            // update db
                            TodoFunctions().updateTodo(todoModel.key!, todoModel);
                          }
                        },
                        child: Container(
                          height: 35,
                          width: 110,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.5, color: whiteColor),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 6, top: 3, left: 6, right: 6),
                            child: Row(
                              children: [
                                const Icon(Icons.create_outlined,
                                    color: whiteColor, size: 18.5),
                                const SizedBox(width: 6),
                                Text('Update',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
