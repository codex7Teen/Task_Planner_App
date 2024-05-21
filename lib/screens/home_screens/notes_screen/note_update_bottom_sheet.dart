
import 'package:flutter/material.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/validations/validations.dart';

// setting globalkey for forms
final _formKey = GlobalKey<FormState>();

// notes name text-controller
final nameController = TextEditingController();

notesUpdateBottomSheet(
    // arguments
    BuildContext context,
    String initialNoteName,
    NotesModel notesModel,
    String? initialCategoryName
    ) {

       // displaying the initial category name as selected if its not null
 // Reset selectedCategory initially
  String? selectedNoteCategory = initialCategoryName;

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
                        controller: nameController..text = initialNoteName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) => Validators()
                            .validateField(name, 'Please enter note name'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: whiteColor, fontSize: 17),
                        decoration: InputDecoration(
                            label: Text('Enter note name',
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
                            return categoriesList.isNotEmpty
                                ? DropdownButtonFormField(
                                  value: selectedNoteCategory,
                                    style: const TextStyle(color: whiteColor),
                                    dropdownColor: blackColor,
                                    icon: const Icon(Icons.arrow_drop_down_rounded,
                                        color: whiteColor, size: 25),
                                    hint: const Text(
                                      'Select Category',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    onChanged: (value) {
                                      selectedNoteCategory = value;
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

                      // update button
                      GestureDetector(
                        onTap: () {
                          // checking validation on button click
                          if (_formKey.currentState!.validate()) {
                            // popping bottomsheet
                            Navigator.pop(context);
                          }

                          final newName = nameController.text.trim();
                          // update note name in db
                          if (newName.isNotEmpty) {
                            // update the name in the model
                            notesModel.name = newName;
                            // update the category in the model
                            notesModel.notesCategory = selectedNoteCategory;
                            // updating db
                            updateNotes(notesModel.id!, notesModel);
                          }
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.5, color: whiteColor),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                bottom: 6, top: 3, left: 6, right: 6),
                            child: Row(
                              children: [
                                Icon(Icons.create_outlined,
                                    color: whiteColor, size: 18.5),
                                SizedBox(width: 6),
                                Text(
                                  'Update',
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
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
