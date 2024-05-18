// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/model/events_model.dart';
import 'package:scribe/db/model/login_model.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/db/model/task_model.dart';
import 'package:scribe/db/model/task_steps_model.dart';
import 'package:scribe/db/model/todo_model.dart';
import 'package:scribe/db/model/todo_steps_model.dart';
import 'package:scribe/screens/home_screens/events_screen/events_page.dart';
import 'package:scribe/screens/home_screens/events_screen/view_event.dart';
import 'package:scribe/screens/home_screens/home_screen.dart';
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
 
    // Run the application
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const ScreenSplash(),
        );
    }
}