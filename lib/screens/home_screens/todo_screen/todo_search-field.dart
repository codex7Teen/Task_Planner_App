// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TodoSearchBarField extends StatefulWidget {
  final VoidCallback onCancelTapped;
  const TodoSearchBarField({super.key, required this.onCancelTapped});

  @override
  State<TodoSearchBarField> createState() => _TodoSearchBarFieldState();
}

class _TodoSearchBarFieldState extends State<TodoSearchBarField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: TextFormField(
  
                        style: Theme.of(context)
                              .textTheme
                              .titleMedium?.copyWith(color: Color.fromARGB(255, 6, 0, 61)),
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
                                  // calls the setstate to toggle between icons.
                                  widget.onCancelTapped();
                                },
                                icon: Icon(Icons.cancel_rounded)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12.0)),
                      ),
                  );
  }
}