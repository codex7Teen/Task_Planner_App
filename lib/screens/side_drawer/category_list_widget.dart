import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/category_db_functions.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
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
          // Updating the shared category list notifier to access category list in other part of app
          categoryListNotifier.value =
              categorylist.map((c) => c.category).toList();

          return ExpansionTile(
            shape: const Border(),
            title: Row(
              children: [
                LottieBuilder.asset('assets/animations/category.json'),
                Text('Categories',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: navyBlue1,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            children: [
              categorylist.isNotEmpty
                  ? ListView.builder(
                      // This is important to make ListView work inside ExpansionTile
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = categorylist[index];
                        return Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // delete the specific category
                                showCategoryAlertDialog(context, data.key);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: navyBlue1,
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ScreenCategory(
                                        categoryName: data.category),
                                  ),
                                ),
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
                                              ?.copyWith(color: navyBlue1),
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_right,
                                      color: navyBlue1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: categorylist.length,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Add any category...',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}
