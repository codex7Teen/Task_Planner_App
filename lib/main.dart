import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/model/category_model.dart';
import 'package:scribe/db/model/events_model.dart';
import 'package:scribe/db/model/login_model.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/db/model/task_steps_model.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/db/model/todo_steps_model.dart';
import 'package:scribe/screens/intro_screens/splash_screen.dart';

Future<void> main() async {
  // To Ensure Flutter widgets binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the LoginModelAdapter
  Hive.registerAdapter(LoginModelAdapter());
  // Register the TaskModelAdapter
  Hive.registerAdapter(TaskModelAdapter());
  // Register the TaskModelAdapter
  Hive.registerAdapter(NotesModelAdapter());
  // Register the TaskModelAdapter
  Hive.registerAdapter(TodoModelAdapter());
  // Register the TaskModelAdapter
  Hive.registerAdapter(TaskStepsModelAdapter());
  // Register the TaskModelAdapter
  Hive.registerAdapter(TodoStepsModelAdapter());
  // Register the EventModelAdapter
  Hive.registerAdapter(EventsModelAdapter());
  // Register the CategoryModelAdapter
  Hive.registerAdapter(CategoryModelAdapter());

  // Call Awesome-notification constructor
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for events')
      ],
      debug: true);

  // Run the application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
  }
}
