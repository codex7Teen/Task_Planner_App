// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String snackbarMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(235, 6, 0, 61),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Icon(Icons.done_all_rounded, color: Colors.white),
              SizedBox(width: 15),
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: 2),
      dismissDirection: DismissDirection.up,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height -186,
        left: 7,
        right: 7
      ),
    ),
  );
}