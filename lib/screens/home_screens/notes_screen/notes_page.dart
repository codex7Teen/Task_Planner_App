// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/screens/home_screens/notes_screen/note_bottom_sheet.dart';
import 'package:scribe/screens/home_screens/notes_screen/note_boxes.dart';
import 'package:scribe/screens/home_screens/notes_screen/notes_search_bar.dart';
import 'package:scribe/screens/home_screens/tasks_screen/task_search_bar.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_bottom_sheet.dart';
import 'package:scribe/screens/side_drawer/drawer.dart';

class ScreenNotes extends StatefulWidget {
  const ScreenNotes({super.key});

  @override
  State<ScreenNotes> createState() => _ScreenNotesState();
}

class _ScreenNotesState extends State<ScreenNotes> {
  //changable index ontap on the all Notes and favorites
  int selectedIndex = 0;

  //Setting global key for scafold state
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  // search icon ontap
  bool searchToggle = false;

  //! S C A F F O L D
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      // Global key
      key: _globalKey,
      // floating button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: FloatingActionButton.extended(
          label: Text('Add Notes', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Color.fromARGB(255, 6, 0, 61))),
          icon: Icon(Icons.add, color: Color.fromARGB(255, 6, 0, 61),),
          onPressed: () {
            // bottom sheet
            notesBottomSheet(context);
          },
          backgroundColor: Colors.white,
        ),
      ),

      body: Stack(
        children: [
          // decoration images
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/decoration_image_1.png',
                // Media Query
                height: MediaQuery.of(context).size.height * .23,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  Visibility(
                    visible: !searchToggle,
                    child: Image.asset(
                      'assets/images/decoration_image_2.png',
                      height: MediaQuery.of(context).size.height * .23,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Divider(
                    indent: 17,
                    endIndent: 17,
                    color: Color.fromARGB(255, 6, 0, 61),
                    thickness: 0.1,
                  )
                ],
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
            child: !searchToggle ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // side bar icon
                IconButton(
                    onPressed: () {
                      // calling open drawer here
                      _globalKey.currentState?.openDrawer();
                    },
                    icon: Icon(Icons.menu_rounded,
                        size: 44, color: Color.fromARGB(255, 6, 0, 61))),
                // date
                Text(DateFormat('dd/MM/yyyy').format(DateTime.now()), style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 6, 0, 61))),
                // search icon
                IconButton(
                    onPressed: () {
                      // Open Search Bar
                      setState(() {
                        searchToggle = !searchToggle;
                      });
                    },
                    icon: Icon(Icons.search_rounded,
                        size: 37, color: Color.fromARGB(255, 6, 0, 61))),
              ],
            ) :
            NotesSearchBar(onCancelTapped: (){
              setState(() {
                searchToggle = !searchToggle;
              });
            },
            notesModelx: notesListNotifier.value,
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 90, bottom: 35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // All Notes
                    GestureDetector(
                      onTap: () {
                        //Gotto all notes
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                        height: 39,
                        width: 109,
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? Color.fromARGB(255, 6, 0, 61)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: Color.fromARGB(255, 6, 0, 61),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.list_rounded,
                              color: selectedIndex == 0
                                  ? Colors.white
                                  : Color.fromARGB(255, 6, 0, 61),
                            ),
                            Text('All Notes',
                                style: selectedIndex == 0
                                    ? Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: Colors.white, fontSize: 15)
                                    : Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color:
                                                  Color.fromARGB(255, 6, 0, 61),
                                              fontSize: 14.5)),
                            SizedBox(width: 3),
                          ],
                        ),
                      ),
                    ),

                    // favorites
                    GestureDetector(
                      onTap: () {
                        //goto favorites
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Container(
                        height: 39,
                        width: 109,
                        decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? Color.fromARGB(255, 6, 0, 61)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: Color.fromARGB(255, 6, 0, 61),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.favorite_border_rounded,
                              size: 22,
                              color: selectedIndex == 1
                                  ? Colors.white
                                  : Color.fromARGB(255, 6, 0, 61),
                            ),
                            Text('Favorites',
                                style: selectedIndex == 1
                                    ? Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: Colors.white, fontSize: 15)
                                    : Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color:
                                                  Color.fromARGB(255, 6, 0, 61),
                                              fontSize: 14.5)),
                            SizedBox(width: 3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28),

                // Seleted field indication text (eg. All tasks, favs etc.)
                selectedIndex == 0
                    ? Text('All Notes', style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Color.fromARGB(255, 6, 0, 61),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                    : Text('Favorites', style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Color.fromARGB(255, 6, 0, 61),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                SizedBox(height: 28),

                //! N O T E - B O X E S S S S
                Expanded(child: NoteBoxes(sectionIndex: selectedIndex, notesSearchToggle: searchToggle,)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
