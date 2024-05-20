// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/db/functions/login_db_functions.dart';
import 'package:scribe/db/model/login_model.dart';
import 'package:scribe/screens/side_drawer/category/add_category_popup.dart';
import 'package:scribe/screens/side_drawer/category/category_page.dart';
import 'package:scribe/screens/side_drawer/category_list_widget.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
// get all categories
  @override
  void initState() {
    super.initState();
    getCategoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 230, 250, 255),
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // logo image
            Center(
                child: Image.asset(
              'assets/images/Scribe-logo-no_background.png',
              width: 90,
            )),
            SizedBox(height: 25),
            Text('Welcome,',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    color: Color.fromARGB(255, 6, 0, 61))),

            // value-listenable builder
            ValueListenableBuilder(
              valueListenable: loginListNotifier,
              builder: (BuildContext ctx, List<LoginModel> loginList,
                  Widget? child) {
                final data = loginList[0];
                return Row(
                  children: [
                    SizedBox(width: 65),
                    Text(
                        // displaying name from database
                        data.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: Color.fromARGB(255, 6, 0, 61)))
                  ],
                );
              },
            ),

            SizedBox(height: 25),

            //! C A T E G O R I E S
            Row(
              children: [
                LottieBuilder.asset('assets/animations/category.json'),
                Text('Categories',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Color.fromARGB(255, 6, 0, 61),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            ),

            SizedBox(height: 5),

            Divider(
              color: Color.fromARGB(
                255,
                6,
                0,
                61,
              ),
              thickness: .1,
            ),

            SizedBox(height: 5),

            // Add category
            Center(
              child: TextButton.icon(
                  onPressed: () {
                    // add category
                    showAddCategoryPopup(context);
                  },
                  icon: Icon(
                    Icons.add_circle_rounded,
                    color: Color.fromARGB(255, 6, 0, 61),
                  ),
                  label: Text('Add Category',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Color.fromARGB(255, 6, 0, 61)))),
            ),

            //! ADDED CATEGORIES
            CategoryWidget()
          ],
        ),
      ),
    );
  }
}
