import 'package:flutter/material.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/db/functions/login_db_functions.dart';
import 'package:scribe/db/model/login_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/side_drawer/about_scribe/about_widget.dart';
import 'package:scribe/screens/side_drawer/category/add_category_popup.dart';
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
    CategoryFunctions().getCategoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: gTabBackground,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // logo image
            Center(
                child: Image.asset(
              'assets/images/scribe_new_logo.png',
              width: 90,
            )),
            const SizedBox(height: 25),
            Text('Welcome,',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    color: navyBlue1)),

            // value-listenable builder
            ValueListenableBuilder(
              valueListenable: loginListNotifier,
              builder: (BuildContext ctx, List<LoginModel> loginList,
                  Widget? child) {
                final data = loginList[0];
                return Row(
                  children: [
                    const SizedBox(width: 65),
                    Text(
                        // displaying name from database
                        data.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: navyBlue1))
                  ],
                );
              },
            ),

            const SizedBox(height: 25),

            //! C A T E G O R I E S
            const Divider(
              color: navyBlue1,
              thickness: .1,
            ),

            const SizedBox(height: 7),

            // Add category
            Center(
              child: TextButton.icon(
                  onPressed: () {
                    // close the drawer
                    Navigator.pop(context);
                    // add category
                    showAddCategoryPopup(context);
                  },
                  icon: const Icon(
                    Icons.add_circle_rounded,
                    color: navyBlue1,
                  ),
                  label: Text('Add Category',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: navyBlue1,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
            ),

            //! ADDED CATEGORIES
            const Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, child: CategoryWidget())),

            const Divider(
              color: navyBlue1,
              thickness: .1,
            ),

            //! ABOUT SECTION
            const ScreenAboutWidget()
          ],
        ),
      ),
    );
  }
}
