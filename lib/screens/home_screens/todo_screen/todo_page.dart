import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scribe/db/functions/todo_db_functions.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_bottom_sheet.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_boxes.dart';
import 'package:scribe/screens/home_screens/todo_screen/todo_searchfield.dart';
import 'package:scribe/screens/side_drawer/drawer.dart';

class ScreenTodo extends StatefulWidget {
  const ScreenTodo({super.key});

  @override
  State<ScreenTodo> createState() => _ScreenTodoState();
}

class _ScreenTodoState extends State<ScreenTodo> {
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
      drawer: const SideDrawer(),
      // Global key
      key: _globalKey,
      // floating action button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: FloatingActionButton.extended(
          label: Text('Add Todo',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: navyBlue1)),
          icon: const Icon(
            Icons.add,
            color: navyBlue1,
          ),
          onPressed: () {
            // bottom sheet
            todoBottomSheet(context);
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
                          // Media Query
                          height: MediaQuery.of(context).size.height * .23,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Divider(
                        indent: 17,
                        endIndent: 17,
                        color: navyBlue1,
                        thickness: 0.1,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0999)
                    ],
                  )
                ],
              ),

              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
                  child: !searchToggle
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // side bar icon
                            IconButton(
                                onPressed: () {
                                  // calling open drawer here
                                  _globalKey.currentState?.openDrawer();
                                },
                                icon: const Icon(Icons.menu_rounded,
                                    size: 44, color: navyBlue1)),
                            // date
                            Text(
                                DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: navyBlue1)),
                            // search icon
                            IconButton(
                                onPressed: () {
                                  // Open Search Bar
                                  setState(() {
                                    searchToggle = !searchToggle;
                                  });
                                },
                                icon: const Icon(Icons.search_rounded,
                                    size: 37, color: navyBlue1)),
                          ],
                        )
                      //! S E A R C H - B A R
                      : TodoSearchBarField(
                          todoListx: todoListNotifier.value,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // All Todo
                        GestureDetector(
                          onTap: () {
                            //goto all todo
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          child: Container(
                            height: 39,
                            width: 109,
                            decoration: BoxDecoration(
                              color:
                                  selectedIndex == 0 ? navyBlue1 : whiteColor,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: navyBlue1,
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
                                      : navyBlue1,
                                ),
                                Text(
                                  'All ToDo',
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
                                              color: navyBlue1, fontSize: 14.5),
                                ),
                                const SizedBox(width: 3),
                              ],
                            ),
                          ),
                        ),

                        // favorites
                        GestureDetector(
                          onTap: () {
                            // goto favs
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          child: Container(
                            height: 39,
                            width: 109,
                            decoration: BoxDecoration(
                              color:
                                  selectedIndex == 1 ? navyBlue1 : whiteColor,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: navyBlue1,
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
                                      : navyBlue1,
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
                                                color: navyBlue1,
                                                fontSize: 14.5)),
                                const SizedBox(width: 3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Seleted field indication text (eg. All tasks, favs etc.)
                    selectedIndex == 0
                        ? Text('All Todo',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: navyBlue1,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                        : Text('Favorites',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: navyBlue1,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),

                    const SizedBox(height: 28),
                    //! T O D O - B O X E S S S
                    TodoBoxes(
                      todoSectionIndex: selectedIndex,
                      todoSearchToggler: searchToggle,
                    ),
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
