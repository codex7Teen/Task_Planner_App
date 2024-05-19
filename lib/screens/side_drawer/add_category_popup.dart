// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:scribe/screens/validations/validations.dart';

//! ADD CATEGORY POP-UP
showAddCategoryPopup(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  TextEditingController categoryNameController = TextEditingController();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 221, 235, 255),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * .22,
            width: MediaQuery.of(context).size.width * .2,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Add new step.',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: categoryNameController,
                      validator: (name) => Validators()
                          .validateField(name, 'Please enter category name'),
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration(
                          labelText: 'Enter category name...',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Color.fromARGB(255, 153, 153, 153))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Spacer(),
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
                              _formKey.currentState!.validate();
                              // Save to db
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
