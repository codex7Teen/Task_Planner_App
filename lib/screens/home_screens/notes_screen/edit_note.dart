
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/home_screens/notes_screen/note_alert_box.dart';
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
        backgroundColor: navyBlue1,
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // notes title
            child: Text(widget.notesModel.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: whiteColor, fontSize: 20))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          //  Edit button
          TextButton(
              onPressed: () {
                notesUpdateBottomSheet(context, widget.notesModel.name, widget.notesModel, widget.notesModel.notesCategory);
              },
              child: Text('Edit',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: whiteColor))),

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
                      ?.copyWith(color: whiteColor))),
        ],
      ),
      //! N O T E S - C O N T A I N E R
      backgroundColor: whiteColor,
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
                  color: const Color.fromARGB(255, 221, 235, 255),
                  borderRadius: BorderRadius.circular(20)),
              //! N O T E S - FIELD
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: noteController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => Validators()
                      .validateField(value, 'Please type something to save.'),
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                      hintText: "Write your notes here...", border: InputBorder.none),
                  maxLines: 30,
                  minLines: 1,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: const Alignment(0.9, 0.95),
        //! S A V E - BTN
        child: FloatingActionButton.extended(
            backgroundColor: navyBlue1,
            label: Text('Save', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: whiteColor)),
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
