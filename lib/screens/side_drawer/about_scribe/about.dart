import 'package:flutter/material.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Scribe'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About Scribe',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 16),
              Text(
                  'Scribe is a comprehensive task planner app packed with tons of functionalities. Users can create, categorize, and play with tasks, notes, to-dos, and events, etc.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Key Features',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                  '1. Tasks: Scribe enables you to efficiently organize your tasks with customizable to-do lists. Stay on top of your priorities and increase productivity with this intuitive task management app.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                  '2. Notes: Scribe enables you to effortlessly create and organize notes on the go. Streamline your productivity with this intuitive app designed to capture your thoughts anytime, anywhere.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                  '3. To-Do Lists: Scribe enables you to efficiently organize your tasks with customizable to-do lists. Stay on top of your priorities and increase productivity with this intuitive task management app.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                  '4. Event Management: Scribe enables you to seamlessly plan and manage events with ease. From scheduling to invitations, stay organized and on track with this versatile event management app.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                  '5. Categorization: Scribe allows users to categorize everything in the app, such as personal, work, etc., making it easier to manage different aspects of life.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Technology',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                  'The app is fully developed using Flutter with Hive database, ensuring a smooth and responsive user experience.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Developer',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text('The app is developed by Dennis Johnson.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Contact',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                  'If you have any questions about Scribe or need support, you can contact us at:',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text('Email: djconnect189@gmail.com\nMobile: +91 7558022365',
                  style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
