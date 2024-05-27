
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scribe/db/functions/task_db_functions.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
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
  bool searchToggle = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // getting all tasks from DB
      drawer: const SideDrawer(),
      // Global key
      key: _globalKey,
      // floating action button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: FloatingActionButton.extended(
          label: Text('Add Task', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: navyBlue1)),
          icon: const Icon(Icons.add, color: navyBlue1,),
          onPressed: () {
            // bottom sheet
            taskBottomSheet(context);
          },
          backgroundColor: whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              // Decoration images
              Column(
                children: [
                  Image.asset(
                    'assets/images/decoration_image_1.png',
                    
                    // Media Qu.—
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  const Spacer(),
                  Visibility(
                    visible: !searchToggle,
                    child: Image.asset('assets/images/decoration_image_2.png',
                        height: MediaQuery.of(context).size.height * 0.23,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill),
                  ),
                  const Divider(
                    indent: 17,
                    endIndent: 17,
                    color: navyBlue1,
                    thickness: 0.1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0999)
                ],
              ),
            
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
                  child: !searchToggle
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // side bar icon (Drawer icon)
                            IconButton(
                                onPressed: () {
                                  // calling open drawer here
                                  _globalKey.currentState?.openDrawer();
                                },
                                icon: const Icon(Icons.menu_rounded,
                                    size: 44,
                                    color: navyBlue1)),
                            // displaying current date
                            Text(DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:  navyBlue1)),
                            // search icon
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    searchToggle = !searchToggle;
                                  });
                                },
                                icon: const Icon(Icons.search_rounded,
                                    size: 37,
                                    color: navyBlue1)),
                          ],
                        )
                      : //! Search B A R (Text Field)
                      SearchBarField(
                        // passing list of taskmodel to searchbar
                        taskListx: taskListNotifier.value,
                        onCancelTapped: () {
                          setState(() {
                            searchToggle = !searchToggle;
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
                                  ?  navyBlue1
                                  : whiteColor,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color:  navyBlue1,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.list_rounded,
                                  color: selectedIndex == 0
                                      ? whiteColor
                                      :  navyBlue1,
                                ),
                                Text('All Tasks',
                                    style: selectedIndex == 0
                                        ? Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: whiteColor, fontSize: 15)
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color:
                                                     navyBlue1,
                                                fontSize: 14.5)),
                                const SizedBox(width: 3),
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
                                  ?  navyBlue1
                                  : whiteColor,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color:  navyBlue1,
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
                                      ? whiteColor
                                      :  navyBlue1,
                                ),
                                Text('Favorites',
                                    style: selectedIndex == 1
                                        ? Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: whiteColor, fontSize: 15)
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color:
                                                     navyBlue1,
                                                fontSize: 14.5)),
                                const SizedBox(width: 3),
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
                                  ?  navyBlue1
                                  : whiteColor,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color:  navyBlue1,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: selectedIndex == 2
                                      ? whiteColor
                                      :  navyBlue1,
                                  size: 22,
                                ),
                                Text('Completed',
                                    style: selectedIndex == 2
                                        ? Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: whiteColor, fontSize: 15)
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color:
                                                     navyBlue1,
                                                fontSize: 14.5)),
                                const SizedBox(width: 2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            
                    const SizedBox(height: 28),
            
                    // Seleted field indication text (eg. All tasks, favs etc.)
                    selectedIndex == 0
                        ? Text('All Tasks',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: navyBlue1,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                        : selectedIndex == 1
                            ? Text('Favorites',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color:  navyBlue1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))
                            : Text('Completed',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: navyBlue1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
            
                    const SizedBox(height: 15),
                    //! T A S K - B O X E S S S
                    TaskBoxes(sectionIndex: selectedIndex, taskSearchToggler: searchToggle,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
