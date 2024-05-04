// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/screens/home_screens/tasks_screen/task_search_bar.dart';
import 'package:scribe/screens/home_screens/tasks_screen/task_bottom_sheet.dart';
import 'package:scribe/screens/home_screens/tasks_screen/task_boxes.dart';
import 'package:scribe/screens/side_drawer/drawer.dart';

class ScreenTasks extends StatefulWidget {
  const ScreenTasks({super.key});

  @override
  State<ScreenTasks> createState() => _ScreenTasksState();
}

class _ScreenTasksState extends State<ScreenTasks> {
  // changable index ontap on the alltasks, favorites and completed
  int selectedIndex = 0;

  // Setting global key for scafold state
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  // search icon ontap
  bool searchToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // getting all tasks from DB
      drawer: SideDrawer(),
      // Global key
      key: _globalKey,
      // floating action button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: FloatingActionButton.extended(
          label: Text('Add Task', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Color.fromARGB(255, 6, 0, 61))),
          icon: Icon(Icons.add, color: Color.fromARGB(255, 6, 0, 61),),
          onPressed: () {
            // bottom sheet
            taskBottomSheet(context);
          },
          backgroundColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // decoration images
            Column(
              children: [
                Image.asset(
                  'assets/images/decoration_image_1.png',
                  // Media Query
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
                Spacer(),
                Image.asset('assets/images/decoration_image_2.png',
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill),
                Divider(
                  indent: 17,
                  endIndent: 17,
                  color: Color.fromARGB(255, 6, 0, 61),
                  thickness: 0.1,
                )
              ],
            ),

            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
                child: searchToggle
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // side bar icon
                          IconButton(
                              onPressed: () {
                                // calling open drawer here
                                _globalKey.currentState?.openDrawer();
                              },
                              icon: Icon(Icons.menu_rounded,
                                  size: 44,
                                  color: Color.fromARGB(255, 6, 0, 61))),
                          // date
                          Text('20/03/2024',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 6, 0, 61))),
                          // search icon
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  searchToggle = !searchToggle;
                                });
                              },
                              icon: Icon(Icons.search_rounded,
                                  size: 37,
                                  color: Color.fromARGB(255, 6, 0, 61))),
                        ],
                      )
                    : //! Search B A R (Text Field)
                    SearchBarField(
                      // passing list of taskmodel to searchbar
                      taskListx: taskListNotifier.value,
                      onCancelTapped: () {
                        setState(() {
                          searchToggle = !searchToggle;
                          // Clear the search query when cancel button is tapped
                          
                        });
                      })),

            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 90, bottom: 35),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // All tasks
                      GestureDetector(
                        onTap: () {
                          // select all tasks
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
                              Text('All Tasks',
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
                          // select favorites
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

                      // Completed
                      GestureDetector(
                        onTap: () {
                          // select completed
                          setState(() {
                            selectedIndex = 2;
                          });
                        },
                        child: Container(
                          height: 39,
                          width: 109,
                          decoration: BoxDecoration(
                            color: selectedIndex == 2
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
                                Icons.check_circle_outline_rounded,
                                color: selectedIndex == 2
                                    ? Colors.white
                                    : Color.fromARGB(255, 6, 0, 61),
                                size: 22,
                              ),
                              Text('Completed',
                                  style: selectedIndex == 2
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
                              SizedBox(width: 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 28),

                  // Seleted field indication text (eg. All tasks, favs etc.)
                  selectedIndex == 0
                      ? Text('All Tasks',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Color.fromARGB(255, 6, 0, 61),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                      : selectedIndex == 1
                          ? Text('Favorites',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: Color.fromARGB(255, 6, 0, 61),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                          : Text('Completed',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: Color.fromARGB(255, 6, 0, 61),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),

                  SizedBox(height: 15),
                  //! T A S K - B O X E S S S
                  TaskBoxes(sectionIndex: selectedIndex),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
