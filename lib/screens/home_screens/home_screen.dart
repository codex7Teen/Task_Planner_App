
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/db/functions/login_db_functions.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/events_screen/add_event_bottom_sheet.dart';
import 'package:scribe/screens/home_screens/events_screen/events_page.dart';
import 'package:scribe/screens/home_screens/notes_screen/notes_page.dart';
import 'package:scribe/screens/home_screens/tasks_screen/tasks_page.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_page.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  // list of all home pages such as task, notes etc.
  final List<Widget> _pages = [
    const ScreenTasks(),
    const ScreenNotes(),
    const ScreenTodo(),
    const ScreenEvents()
  ];

  //! init state
  @override
  void initState() {
    super.initState();
    // calling the function to get value from DB.
    LoginFunctions().getLoginDetails();
    // calling the function to get value from DB.
    TaskFunctions().getTaskDetails();
    // calling the function to get value from DB.
    NotesFunctions().getNotesDetails();
    // calling the function to get value from DB.
    TodoFunctions().getTodoDetails();
    // calling the function to get value from DB.
    CategoryFunctions().getCategoryDetails();
  }

  //! Dispose
  @override
  void dispose() {
    // dispose the event title field
    eventNameController.dispose();
    super.dispose();
  }

  // setting current index = 0
  int _selectedIndex = 0;

  // on bottom navigation clicked
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // adding the four home-pages to body
      body: _pages[_selectedIndex],
      backgroundColor: whiteColor,

      // bottom navigation bar
      bottomNavigationBar: Container(
        color: whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: GNav(
            onTabChange: _navigateBottomBar,
            duration: const Duration(milliseconds: 200),
            activeColor: navyBlueLightColor,
            color: navyBlue1,
            backgroundColor: whiteColor,
            tabBackgroundColor: gTabBackground,
            // icons and label
            tabs: [
              GButton(
                icon: Icons.list_alt_rounded,
                text: 'Tasks', textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color:  navyBlue1, fontSize: 15),
                gap: 10,
                padding: const EdgeInsets.all(15),
              ),
              GButton(
                icon: Icons.library_books_outlined,
                text: 'Notes', textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color:  navyBlue1, fontSize: 15),
                gap: 10,
                padding: const EdgeInsets.all(15),
              ),
              GButton(
                icon: Icons.fact_check_outlined,
                text: 'ToDo', textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color:  navyBlue1, fontSize: 15),
                gap: 10,
                padding: const EdgeInsets.all(15),
              ),
              GButton(
                icon: Icons.calendar_month_outlined,
                text: 'Events', textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color:  navyBlue1, fontSize: 15),
                gap: 10,
                padding: const EdgeInsets.all(15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
