// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/screens/home_screens/notes_screen/note_alert_box.dart';

class ScreenEditNotes extends StatelessWidget {
  // creating an object of Notesmodel and accepting data to display
  final NotesModel note;
  const ScreenEditNotes({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 0, 61),
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // notes title
            child: Text(note.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white, fontSize: 20))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          //  Edit button
          TextButton(
              onPressed: () {},
              child: Text('Edit',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white))),

          // Delete button
          TextButton(
              onPressed: () {
                // show alertbox and then delete
                showNotelAertDialog(context, note.id);
              },
              child: Text('Delete',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white))),
        ],
      ),
      //! N O T E S - C O N T A I N E R
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          // notes container
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 235, 255),
                borderRadius: BorderRadius.circular(20)),
            //! N O T E S - FIELD
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    hintText: 'Type something...', border: InputBorder.none),
                maxLines: 30,
                minLines: 1,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment(0.9, 0.95),
        child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 6, 0, 61),
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // go back
              Navigator.of(context).pop();
            }),
      ),
    );
  }
}
