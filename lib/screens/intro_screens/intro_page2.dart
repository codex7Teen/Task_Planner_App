// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 220),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 92),
          // image
          Expanded(child: Center(child: Image.asset('assets/images/todo.jpg'))),
          const SizedBox(height: 56),
          // heading text
          Text(
            'Create Todo lists\nwith Scribe.',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900, fontSize: 28, height: 1.1),
          ),
          const SizedBox(height: 12),
          // sub text
          Text(
            "Scribe enables you to efficiently organize your tasks with customizable to-do lists. Stay on top of your priorities and increase productivity with this intuitive task management app.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color.fromARGB(255, 86, 86, 86), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
