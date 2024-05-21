import 'package:flutter/material.dart';
import 'package:scribe/decorators/colors/app_colors.dart';

void showSnackBar(BuildContext context, String snackbarMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
          color: snackBarColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              const Icon(Icons.done_all_rounded, color: Colors.white),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(snackbarMessage)
                ],
              )
            ],
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: transparentColor,
      elevation: 0,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.up,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height -186,
        left: 7,
        right: 7
      ),
    ),
  );
}