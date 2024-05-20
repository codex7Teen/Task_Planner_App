
// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_import

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/db/model/task_steps_model.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/db/model/todo_steps_model.dart';
import 'package:scribe/screens/validations/validations.dart';

// ! ADD-TODO POP-UP
showAddTodoPopup(BuildContext context, TodoModel todoModel) {
  final _formKey = GlobalKey<FormState>();

  TextEditingController todoStepNameController = TextEditingController();

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
                  key: _formKey ,
                  child: Column(
                    children: [
                      Text('Add new todo.', style: Theme.of(context).textTheme.titleMedium,),
                  
                      SizedBox(height: 20,),

                      TextFormField(
                        controller: todoStepNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) => Validators()
                                    .validateField(name, 'Please enter todo name'),
                        style: Theme.of(context).textTheme.titleMedium,
                        decoration: InputDecoration(
                          labelText: 'Enter todo name...',
                          labelStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge?.copyWith(color: Color.fromARGB(255, 153, 153, 153))
                        ),
                      ),
                  
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Spacer(),
                          // C R E A T E - B U T T O N
                          TextButton(onPressed: (){
                            // do validation
                            _formKey.currentState!.validate();
                            // Save to db
                            final todoStep = todoStepNameController.text.trim(); 

                            if(todoStep.isNotEmpty) {
                              // getting the model
                              var todoSteps = TodoStepsModel(stepTodo: todoStep);
                              // adding the value to todosteps list which is in todoModel
                              todoModel.todoStepsList.add(todoSteps);
                              updateTodo(todoModel.key, todoModel);
                              Navigator.pop(context);
                            }
                            
                          }, child: Text('Create', style: Theme.of(context).textTheme.labelLarge,)),
                  
                          // C A N C E L - B U T T O N
                          TextButton(onPressed: (){
                            // pop
                            Navigator.pop(context);
                          }, child: Text('Cancel', style: Theme.of(context).textTheme.labelLarge)),
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