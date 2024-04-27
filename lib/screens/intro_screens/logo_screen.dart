// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scribe/screens/intro_screens/app_intro.dart';

class ScreenLogo extends StatelessWidget {
  const ScreenLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // decoration image 1
            children: [Image.asset('assets/images/decoration_image_1.png',
            // Media Query
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
            )],
          ),
          Column(
            children: [
              Image.asset(
                // Scribe logo text
                'assets/images/scribe-logo-text.jpg',
                width: 280,
              ),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ScreenIntro()));
                },
                // Lets Begin Button
                child: Container(
                  width: 55,
                  height: 39,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromARGB(255, 6, 0, 61)),
                  child: const Icon(
                    Icons.navigate_next_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Let's begin.",
                style: Theme.of(context)
                            .textTheme
                            .headlineLarge?.copyWith(fontWeight: FontWeight.w300, fontSize: 26)
              )
            ],
          ),
          
          // decoration image 2
          Column(
            children: [Image.asset('assets/images/decoration_image_2.png',
            // Media Query
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
            )],
          )
        ],
      ),
    );
  }
}
