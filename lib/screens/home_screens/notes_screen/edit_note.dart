// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, use_build_context_synchronously, unused_import, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/screens/home_screens/notes_screen/note_alert_box.dart';
import 'package:scribe/screens/home_screens/notes_screen/note_bottom_sheet.dart';
import 'package:scribe/screens/home_screens/notes_screen/note_update_bottom_sheet.dart';
import 'package:scribe/screens/validations/validations.dart';

class ScreenEditNotes extends StatefulWidget {
  // creating an object of Notesmodel and accepting data to display
  final NotesModel notesModel;
  const ScreenEditNotes({super.key, required this.notesModel});

  @override
  State<ScreenEditNotes> createState() => _ScreenEditNotesState();
}

class _ScreenEditNotesState extends State<ScreenEditNotes> {
  // setting globalkey for forms
  final _formKey = GlobalKey<FormState>();

  // controller for note
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    noteController.text = widget.notesModel.note ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 0, 61),
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // notes title
            child: Text(widget.notesModel.name,
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
              onPressed: () {
                notesUpdateBottomSheet(context, widget.notesModel.name, widget.notesModel);
              },
              child: Text('Edit',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white))),

          // Delete button
          TextButton(
              onPressed: () {
                // show alertbox and then delete
                showNotelAertDialog(context, widget.notesModel.id);
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
        child: Form(
          key: _formKey,
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
                  controller: noteController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => Validators()
                      .validateField(value, 'Please type something to save.'),
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
      ),
      floatingActionButton: Align(
        alignment: Alignment(0.9, 0.95),
        //! S A V E - BTN
        child: FloatingActionButton.extended(
            backgroundColor: Color.fromARGB(255, 6, 0, 61),
            label: Text('Save', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
            onPressed: () {
              // validate the notes
              if (_formKey.currentState!.validate()) {
                // calling function to update and save the data
                saveAndUpdateNote();
              }
            }),
      ),
    );
  }

  // update and save note method
  Future<void> saveAndUpdateNote() async {
    final notesDB = await Hive.openBox<NotesModel>(NotesModel.boxName);
    // Update note content
    widget.notesModel.note = noteController.text;
    // Save to Hive
    await notesDB.put(widget.notesModel.id, widget.notesModel);
    // pop context
    Navigator.pop(context);
    // notify listeners
    notesListNotifier.notifyListeners();
  }
}
