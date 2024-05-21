
import 'package:flutter/material.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/db/model/todo_steps_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/validations/validations.dart';

// ! ADD-TODO POP-UP
showAddTodoPopup(BuildContext context, TodoModel todoModel) {
  final formKey = GlobalKey<FormState>();

  TextEditingController todoStepNameController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: alertBackgroundColor,
            content: SizedBox(
              height: MediaQuery.of(context).size.height * .22,
              width: MediaQuery.of(context).size.width * .2,
              child: Form(
                key: formKey ,
                child: Column(
                  children: [
                    Text('Add new todo.', style: Theme.of(context).textTheme.titleMedium,),
                
                    const SizedBox(height: 20,),
              
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
                                  .labelLarge?.copyWith(color: const Color.fromARGB(255, 153, 153, 153))
                      ),
                    ),
                
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const Spacer(),
                        // C R E A T E - B U T T O N
                        TextButton(onPressed: (){
                          // do validation
                          formKey.currentState!.validate();
                          // Save to db
                          final todoStep = todoStepNameController.text.trim(); 
              
                          if(todoStep.isNotEmpty) {
                            // getting the model
                            var todoSteps = TodoStepsModel(stepTodo: todoStep);
                            // adding the value to todosteps list which is in todoModel
                            todoModel.todoStepsList.add(todoSteps);
                            TodoFunctions().updateTodo(todoModel.key, todoModel);
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
          );
        });
  }