// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 220),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            // image
            Expanded(child: Center(child: Image.asset('assets/images/notess.jpg'))),
            const SizedBox(height: 25,),
            // heading text
            Text('Create notes\nwith Scribe.',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900, fontSize: 28, height: 1.1)
            ),
             const SizedBox(height: 12),
             // sub text
            Text(
                'Scribe enables you to effortlessly create and organize notes on the go. Streamline your productivity with this intuitive app designed to capture your thoughts anytime, anywhere.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color.fromARGB(255, 86, 86, 86)),
                ),
          ],
        ),
      ),
    );
  }
}
