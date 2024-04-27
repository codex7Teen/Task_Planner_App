// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/screens/home_screens/notes_screen/edit_note.dart';

class NoteBoxes extends StatefulWidget {
  const NoteBoxes({super.key});

  @override
  State<NoteBoxes> createState() => _NoteBoxesState();
}

class _NoteBoxesState extends State<NoteBoxes> {
  // fovorites
  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    // note boxes builder
    return ValueListenableBuilder(
        valueListenable: notesListNotifier,
        builder:
            (BuildContext context, List<NotesModel> notesList, Widget? child) {
              // showing add any add-notes GIF if no data to display.
          return notesListNotifier.value.isEmpty
              ? Center(
                child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Lottie.asset('assets/animations/notes.json', width: 227),
                      Text('Add your notes...',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 24))
                    ],
                  ),
              )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final data = notesList[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //! notes heading
                        Container(
                          height: 43,
                          width: 185,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 6, 0, 61),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    // Favorite note
                                    setState(() {
                                      favorite = !favorite;
                                    });
                                  },
                                  icon: Icon(
                                    favorite
                                        ? Icons.favorite_border_rounded
                                        : Icons.favorite_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Text(
                                  data.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: Colors.white, fontSize: 14.5),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                scrollDirection: Axis.horizontal,
                              )),
                            ],
                          ),
                        ),

                        //! notes content
                        GestureDetector(
                          onTap: () {
                            // goto view and edit page
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ScreenEditNotes(note: data);
                            }));
                          },
                          child: Container(
                            height: 133.7,
                            width: 185,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 221, 235, 255),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                          ),
                        )
                      ],
                    );
                  },
                  // telling how much notes to display
                  itemCount: notesList.length);
        });
  }
}
