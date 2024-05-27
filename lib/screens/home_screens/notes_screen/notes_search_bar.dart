import 'package:flutter/material.dart';
import 'package:scribe/db/functions/notes_db_functions.dart';
import 'package:scribe/db/model/notes_model.dart';
import 'package:scribe/decorators/colors/app_colors.dart';

class NotesSearchBar extends StatefulWidget {
  final VoidCallback onCancelTapped;
  final List<NotesModel> notesModelx;
  const NotesSearchBar(
      {super.key, required this.onCancelTapped, required this.notesModelx});

  @override
  State<NotesSearchBar> createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends State<NotesSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 11),
      child: TextFormField(
        onChanged: (value) {
          // search for notes method
          searchNoteFields(value);
        },
        style:
            Theme.of(context).textTheme.titleMedium?.copyWith(color: navyBlue1),
        decoration: InputDecoration(
            hintText: 'Search...',
            fillColor: whiteColor,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            suffixIcon: IconButton(
                onPressed: () {
                  // clearing the notesfield
                  clearNotesField();
                  // calls the setstate to toggle between icons.
                  widget.onCancelTapped();
                },
                icon: const Icon(Icons.cancel_rounded)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 12.0)),
      ),
    );
  }

  // method for searching for notes
  void searchNoteFields(String query) {
    List<NotesModel> filteredNotes = widget.notesModelx
        .where((note) => note.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // assigning the filterednotes to notesmodel
    setState(() {
      notesListNotifier.value = filteredNotes;
    });
  }

  // method to clear the field
  void clearNotesField() {
    searchNoteFields('');
  }
}
