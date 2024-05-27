import 'package:flutter/material.dart';
import 'package:scribe/screens/home_screens/home_screen.dart';

class Validators {
  // checks if user entered any input for login screen and proceeds to home page.
  //! Login session
  void checkLogin(BuildContext context, TextEditingController nameController) {
    var userName = nameController.text;
    userName.isNotEmpty
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ScreenHome()))
        : null;
  }

  // Validator function for textfield which displays an error message.
  String? validateField(String? name, String errorMessage) {
    if (name == null || name.isEmpty) {
      return errorMessage;
    }
    return null;
  }
}
