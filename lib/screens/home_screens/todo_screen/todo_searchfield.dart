import 'package:flutter/material.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';

class TodoSearchBarField extends StatefulWidget {
  final List<TodoModel> todoListx;
  final VoidCallback onCancelTapped;
  const TodoSearchBarField({super.key, required this.onCancelTapped, required this.todoListx});

  @override
  State<TodoSearchBarField> createState() => _TodoSearchBarFieldState();
}

class _TodoSearchBarFieldState extends State<TodoSearchBarField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: TextFormField(
                        onChanged: (value) {
                          // search for todos
                          searchTodoFields(value);
                        },
                        style: Theme.of(context)
                              .textTheme
                              .titleMedium?.copyWith(color: navyBlue1),
                        decoration: InputDecoration(
                            hintText: 'Search...',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none
                                ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                   // clear the todosearch field
                                   clearTodoField();
                                  // calls the setstate to toggle between icons.
                                  widget.onCancelTapped();
                                },
                                icon: const Icon(Icons.cancel_rounded)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12.0)),
                      ),
                  );
  }

  // method to search for todos
  void searchTodoFields(String query) {
    List<TodoModel> filteredTodos = widget.todoListx.where((todo) => todo.name.toLowerCase().contains(query.toLowerCase())).toList();
    // assigning the filterd-todos to todomodel
    setState(() {
      todoListNotifier.value = filteredTodos;
    });
  }

  // clear the todosearch field
  void clearTodoField() {
    searchTodoFields('');
  }
}