// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_widget.dart';
import 'package:scribe/screens/side_drawer/drawer.dart';

class ScreenEvents extends StatefulWidget {
  const ScreenEvents({super.key});

  @override
  State<ScreenEvents> createState() => _ScreenEventsState();
}

class _ScreenEventsState extends State<ScreenEvents> {
  //Setting global key for scafold state
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      // Global key
      key: _globalKey,
      // floating button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // open add events page
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 6, 0, 61),
        ),
      ),

      body: Stack(
        children: [
          // decoration images
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/decoration_image_1.png',
                // Media Query
                height: MediaQuery.of(context).size.height * .23,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/decoration_image_2.png',
                    // Media Query
                    height: MediaQuery.of(context).size.height * .23,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  Divider(
                    indent: 17,
                    endIndent: 17,
                    color: Color.fromARGB(255, 6, 0, 61),
                    thickness: 0.1,
                  )
                ],
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // side bar icon
                IconButton(
                    onPressed: () {
                      // calling open drawer here
                      _globalKey.currentState?.openDrawer();
                    },
                    icon: Icon(Icons.menu_rounded,
                        size: 44, color: Color.fromARGB(255, 6, 0, 61))),

                SizedBox(width: 95),
                // date
                Text('20/03/2024',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 6, 0, 61))),
              ],
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 90, bottom: 35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // EVENTS LOGO
                    Container(
                      height: 39,
                      width: 109,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Color.fromARGB(255, 6, 0, 61),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: Color.fromARGB(255, 6, 0, 61),
                          ),
                          Text('Events',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: Color.fromARGB(255, 6, 0, 61),
                                      fontSize: 14.5)),
                          SizedBox(width: 3),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28),

                // Calendar logo
                Text(
                  'Current date',
                  style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Color.fromARGB(255, 6, 0, 61),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 28),

                //! C A L E N D A R -------

                CalendarWidget(),

                SizedBox(height: 40),
              ],
            ),
          )
        ],
      ),
    );
  }
}
