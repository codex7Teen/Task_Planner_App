// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scribe/screens/intro_screens/intro_page1.dart';
import 'package:scribe/screens/intro_screens/intro_page2.dart';
import 'package:scribe/screens/intro_screens/intro_page3.dart';
import 'package:scribe/screens/intro_screens/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ScreenIntro extends StatefulWidget {
  const ScreenIntro({super.key});

  @override
  State<ScreenIntro> createState() => ScreenIntroState();
}

class ScreenIntroState extends State<ScreenIntro> {
  
  // controller to track the current page we're on
  final PageController _controller = PageController();

  // bool to check whether on last page
  bool _onlastpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
      child: Stack(
        children: [
          // page view
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _onlastpage = (index == 2);
              });
            },
            children: const [IntroPage1(), IntroPage2(), IntroPage3()],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 95,
            child: Container(
              alignment: const Alignment(0, 0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // dot indicators
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.black,
                        dotHeight: 7,
                        dotWidth: 7),
                  ),
                  const SizedBox(height: 28),

                  // Next button and done button
                  _onlastpage
                      ?
                      // done button
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const ScreenLogin()));
                          },
                          child: Container(
                              width: 95,
                              height: 43,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: Color.fromARGB(255, 6, 0, 61)),
                              child: Center(
                                child: Text(
                                  'Done',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 18)
                                ),
                              )),
                        )
                      :
                      // Next button
                      GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          },
                          child: Container(
                              width: 95,
                              height: 43,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: Color.fromARGB(255, 6, 0, 61)),
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 18)
                                ),
                              )),
                        ),
                ],
              ),
            ),
          ),

          // Skip Button
          Positioned(
            top: 10,
            right: 14,
            child: TextButton(onPressed: (){
              // skip to last intro page
              _controller.jumpToPage(2);
            }, child: Text('SKIP >>',
            style: TextStyle(
              color: Color.fromARGB(255, 6, 0, 61) ,
              fontSize: 13
            ),
            )))
        ],
      ),
    ));
  }
}
