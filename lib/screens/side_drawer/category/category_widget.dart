// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/screens/side_drawer/category/category_delete_alert.dart';
import 'package:scribe/screens/side_drawer/category/category_page.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: categoryNotifier,
          builder: (context, categorylist, Widget? child) {

             // Updating the shared category list notifier to access catgry-list in other part of app
            categoryListNotifier.value = categorylist.map((c) => c.category).toList();
            
            return ListView.builder(
                itemBuilder: (context, index) {
                  final data = categorylist[index];
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // delete the specific category
                            showCategoryAlertDialog(context, data.key);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 6, 0, 61),
                          )),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ScreenCategory(categoryName: data.category,))),
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    data.category,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: Color.fromARGB(255, 6, 0, 61)),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_right,
                                color: Color.fromARGB(255, 6, 0, 61),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: categorylist.length);
          }),
    );
  }
}
