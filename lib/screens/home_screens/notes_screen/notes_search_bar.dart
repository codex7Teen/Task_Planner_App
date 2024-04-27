// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NotesSearchBar extends StatefulWidget {
  final VoidCallback onCancelTapped;
  const NotesSearchBar({super.key, required this.onCancelTapped});

  @override
  State<NotesSearchBar> createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends State<NotesSearchBar> {

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