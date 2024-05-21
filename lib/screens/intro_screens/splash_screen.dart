// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:scribe/db/functions/login_db_functions.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/home_screen.dart';
import 'package:scribe/screens/intro_screens/logo_screen.dart';
class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override

  //! I N I T - STATE
  void initState() {
    // goto logo screen
    gotoLogoScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
          child: Image.asset('assets/images/Scribe-logo-no_background.png',
              width: 135)),
    );
  }

  // ! S P L A S H
  // wait 3 seconds and goto logoscreen
  Future<void> gotoLogoScreen() async {
    // checking whether user has logged in
    if(await checkLogin())
    {
      // if user loggeg in, goto homescreen
 await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ScreenHome()));
    }
    else{
      // if user has not loggeg in, goto logo screen
      await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ScreenLogo()));
    }
  }

}
