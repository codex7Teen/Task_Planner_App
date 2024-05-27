import 'package:flutter/material.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/db/model/category_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/validations/validations.dart';

//! ADD CATEGORY POP-UP
showAddCategoryPopup(BuildContext context) {
  final formKey = GlobalKey<FormState>();

  TextEditingController categoryNameController = TextEditingController();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: alertBackgroundColor,
          content: SizedBox(
            height: MediaQuery.of(context).size.height * .22,
            width: MediaQuery.of(context).size.width * .2,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'Add new category.',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLength: 20,
                      controller: categoryNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (name) => Validators()
                          .validateField(name, 'Please enter category name'),
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration(
                          labelText: 'Enter category name...',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: const Color.fromARGB(
                                      255, 153, 153, 153))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        // C A N C E L - B U T T O N
                        TextButton(
                            onPressed: () {
                              // pop
                              Navigator.pop(context);
                            },
                            child: Text('Cancel',
                                style: Theme.of(context).textTheme.labelLarge)),
                        // C R E A T E - B U T T O N
                        TextButton(
                            onPressed: () {
                              // do validation
                              final validated =
                                  formKey.currentState!.validate();

                              if (validated) {
                                // Save to db
                                final categoryName =
                                    categoryNameController.text.trim();

                                final category =
                                    CategoryModel(category: categoryName);
                                // add category to db
                                CategoryFunctions().addCategory(category);
                                // pop
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Create',
                              style: Theme.of(context).textTheme.labelLarge,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
