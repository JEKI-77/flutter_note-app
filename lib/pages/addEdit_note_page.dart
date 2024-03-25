// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:note_app/database/note_database.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/widgets/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({super.key, this.note});

  final Note? note;

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  late bool _isImportant;
  late int _number;
  late String _title;
  late String _description;
  final _formKey = GlobalKey<FormState>();
  bool _isUpdateForm = false; // Corrected variable name

  @override
  void initState() {
    super.initState();
    _isImportant = widget.note?.isImportant ?? false;
    _number = widget.note?.number ?? 0;
    _title = widget.note?.title ?? '';
    _description = widget.note?.description ?? '';
    _isUpdateForm = widget.note !=
        null; // Set _isUpdateForm based on whether note is provided
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isUpdateForm ? 'Edit' : 'Add'), // Corrected condition
        actions: [_buildButtonSave()],
      ),
      body: NoteFormWidget(
        key: _formKey,
        isImportant: _isImportant,
        number: _number,
        title: _title,
        description: _description,
        onChangeIsImportant: (value) {
          setState(() {
            _isImportant = value;
          });
        },
        onChangeNumber: (value) {
          setState(() {
            _number = value;
          });
        },
        onChangeTitle: (value) {
          setState(() {
            _title = value;
          });
        },
        onChangeDescription: (value) {
          setState(() {
            _description = value;
          });
        },
      ),
    );
  }

  Widget _buildButtonSave() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: ElevatedButton(
        onPressed: () async {
          final isValid = _formKey.currentState?.validate();
          if (isValid ?? false) {
            if (_isUpdateForm) {
              await _updateNote();
            } else {
              await _addNote();
            }
            Navigator.pop(context);
          }
        },
        child: const Text('Save'),
      ),
    );
  }

  Future<void> _addNote() async {
    final note = Note(
      number: _number,
      title: _title,
      description: _description,
      createdTime: DateTime.now(),
    );

    await NoteDatabase.instance.create(note);
  }

  Future<void> _updateNote() async {
    final updateNote = Note(
      id: widget.note!.id, // Pass the ID of the note being updated
      number: _number,
      title: _title,
      description: _description,
      createdTime: widget.note!.createdTime, // Retain the original createdTime
    );

    await NoteDatabase.instance.updateNote(updateNote);
  }
}
