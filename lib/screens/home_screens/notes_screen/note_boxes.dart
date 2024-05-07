// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/screens/home_screens/notes_screen/edit_note.dart';

class NoteBoxes extends StatefulWidget {
  final int sectionIndex;
  const NoteBoxes({super.key, required this.sectionIndex});

  @override
  State<NoteBoxes> createState() => _NoteBoxesState();
}

class _NoteBoxesState extends State<NoteBoxes> {
  @override
  Widget build(BuildContext context) {
    // note boxes builder
    return ValueListenableBuilder(
        valueListenable: notesListNotifier,
        builder:
            (BuildContext context, List<NotesModel> notesList, Widget? child) {
          // Filter notes based on selectedIndex
          final filteredNotes = widget.sectionIndex == 0
              ? notesList
              : notesList.where((note) => note.isFavorite).toList();
          // showing add any add-notes GIF if no data to display and if on allNotes section
          return notesListNotifier.value.isEmpty && widget.sectionIndex == 0
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
                    // Using filteredNotes
                    final data = filteredNotes[index];
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
                              // favorite icon
                              IconButton(
                                  onPressed: () {
                                    // Favorite note
                                    setState(() {
                                      data.isFavorite = !data.isFavorite;
                                      // Save data to db
                                      updateNotes(data.id!, data);
                                    });
                                  },
                                  icon: Icon(
                                    data.isFavorite
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
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
                              return ScreenEditNotes(notesModel: data);
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

                              // showing lottie only if notes is empty
                              child: data.note?.isEmpty ?? true
                                  ? // lottie animation
                                  LottieBuilder.asset(
                                      repeat: false,
                                      'assets/animations/note_contents2.json')
                                  : Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                          child: Text(
                                              data.note!)),
                                    )),
                        )
                      ],
                    );
                  },
                  // telling how much notes to display
                  itemCount: filteredNotes.length);
        });
  }
}
