import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/notes_screen/edit_note.dart';

class NotesCategory extends StatefulWidget {
  final String selectedCategory;
  const NotesCategory({super.key, required this.selectedCategory});

  @override
  State<NotesCategory> createState() => _NotesCategoryState();
}

class _NotesCategoryState extends State<NotesCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 150, bottom: 35),
      child: ValueListenableBuilder(
          valueListenable: notesListNotifier,
          builder: (BuildContext context, List<NotesModel> notesList,
              Widget? child) {
            //! F I L T E R I N G
            // filtering task based on category
            final filteredNotes = notesList
                .where(
                    (notes) => notes.notesCategory == widget.selectedCategory)
                .toList();
            // showing add your notes gif
            if (filteredNotes.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 103,
                    ),
                    Lottie.asset('assets/animations/notes.json', width: 222),
                    Text('Add your notes...',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 24))
                  ],
                ),
              );
            } else {
              // viewing the available notes according to filtered-notes
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          decoration: const BoxDecoration(
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
                                      NotesFunctions()
                                          .updateNotes(data.key!, data);
                                    });
                                  },
                                  icon: Icon(
                                    data.isFavorite
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: whiteColor,
                                    size: 18,
                                  )),
                              Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  data.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: whiteColor, fontSize: 14.5),
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                              decoration: const BoxDecoration(
                                  color: alertBackgroundColor,
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
                                          child: Text(data.note!)),
                                    )),
                        )
                      ],
                    );
                  },
                  // telling how much notes to display
                  itemCount: filteredNotes.length);
            }
          }),
    );
  }
}
