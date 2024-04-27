// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 220),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 110),
          // image
          Expanded(child: Center(child: Image.asset('assets/images/events.jpg'))),
          const SizedBox(height: 80),
          // heading text
          Text(
            'Create events\nwith Scribe.',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900, fontSize: 28, height: 1.1)
          ),
          const SizedBox(height: 12),
          // sub text
          Text(
            "Scribe enables you to seamlessly plan and manage events with ease. From scheduling to invitations, stay organized and on track with this versatile event management app.",
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color.fromARGB(255, 86, 86, 86),))
        ],
      ),
    );
  }
}
