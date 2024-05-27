
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scribe/db/functions/login_db_functions.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/events_screen/calendar_widget.dart';
import 'package:scribe/screens/home_screens/events_screen/event_bottom_sheet.dart';
import 'package:scribe/screens/side_drawer/drawer.dart';

class ScreenEvents extends StatefulWidget {
  const ScreenEvents({super.key});

  @override
  State<ScreenEvents> createState() => _ScreenEventsState();
}

class _ScreenEventsState extends State<ScreenEvents> {

// datetime notifier which contains the FROM-datetime
  late ValueNotifier<DateTime> fromDateNotifier;
  
  // datetime notifier which contains the TO-datetime
  late ValueNotifier<DateTime> toDateNotifier;

    // Setting global key for scafold state
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
   
//! INIT State
@override
  void initState() {
    super.initState();
    final now = DateTime.now();
    fromDateNotifier = ValueNotifier<DateTime>(now);
    toDateNotifier = ValueNotifier<DateTime>(now.add(const Duration(hours: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      // Global key
      key: _globalKey,
      // floating action button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: FloatingActionButton.extended(
          label: Text('Add Events', style: Theme.of(context).textTheme.labelLarge!.copyWith(color:  navyBlue1)),
          icon: const Icon(Icons.add, color: navyBlue1,),
          onPressed: () {
            // fetch username from the loginListNotifier
            final userName = loginListNotifier.value[0].name;

            // open add event bottom sheet
            eventBottomSheet(context, fromDateNotifier, toDateNotifier, userName);
          },
          backgroundColor: whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
                  const Divider(
                    indent: 17,
                    endIndent: 17,
                    color: navyBlue1,
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
                    icon: const Icon(Icons.menu_rounded,
                        size: 44, color: navyBlue1)),

                const SizedBox(width: 95),
                // date
                Text(DateFormat('dd/MM/yyyy').format(DateTime.now()),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:  navyBlue1)),
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
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: navyBlue1,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                            color: navyBlue1,
                          ),
                          Text('Events',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color:  navyBlue1,
                                      fontSize: 14.5)),
                          const SizedBox(width: 3),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Calendar logo
                Text(
                  'Add your events.',
                  style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 22)
                                  
                ),
                const SizedBox(height: 28),

                //! C A L E N D A R -------
                const CalendarWidget(),

                const SizedBox(height: 40),
              ],
            ),
          )
        ],
      ),
    );
  }
}
