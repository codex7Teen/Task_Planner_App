import 'package:flutter/material.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/home_screen.dart';
import 'package:scribe/screens/side_drawer/category/notes_category.dart';
import 'package:scribe/screens/side_drawer/category/tasks_category.dart';
import 'package:scribe/screens/side_drawer/category/todo_category.dart';

class ScreenCategory extends StatefulWidget {
  final String categoryName;
  const ScreenCategory({super.key, required this.categoryName});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  // Headings
  List headings = ['Tasks', 'Notes', 'Todo'];

  // variable for tracking index of pages
  var pageIndex = 0;

  // controller to track current page
  final PageController _controller2 = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/decoration_image_1.png'),
            ],
          ),
          PageView(
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            controller: _controller2,
            children: [
              TasksCategory(
                selectedCategory: widget.categoryName,
              ),
              NotesCategory(
                selectedCategory: widget.categoryName,
              ),
              TodoCategory(
                selectedCategory: widget.categoryName,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // go back screen button
                    IconButton(
                        onPressed: () {
                          //go back
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const ScreenHome()));
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: navyBlue1,
                        )),

                    Row(
                      children: [
                        // left button
                        IconButton(
                            onPressed: () {
                              _controller2.previousPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            },
                            icon: const Icon(
                              Icons.arrow_left_rounded,
                              color: navyBlue1,
                              size: 40,
                            )),

                        // Headings
                        Text(headings[pageIndex],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: navyBlue1,
                                    fontWeight: FontWeight.w600)),

                        // right button
                        IconButton(
                            onPressed: () {
                              _controller2.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            },
                            icon: const Icon(
                              Icons.arrow_right_rounded,
                              color: navyBlue1,
                              size: 40,
                            )),
                      ],
                    ),

                    const SizedBox(
                      width: 50,
                    )
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),

                //Category heading
                //IntrinsicWidth widget make the container width adjust according to text inside
                IntrinsicWidth(
                  child: Container(
                    height: 39,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: navyBlue1,
                        width: .5,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.categoryName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: navyBlue1,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
