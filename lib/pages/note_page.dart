import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/database/note_database.dart';
import 'package:note_app/pages/addEdit_note_page.dart';
import 'package:note_app/pages/note_detail_page.dart';
import 'package:note_app/widgets/note_card_widget.dart';

import '../models/note.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> _notes;
  bool _listLoading = true;

  Future<void> _refreshNotes() async {
    setState(() {
      _listLoading = true;
    });
    _notes = await NoteDatabase.instance.getAllNote();
    setState(() {
      _listLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditNotePage()),
          );

          _refreshNotes();
        },
        child: const Icon(Icons.add),
      ),
      body: _notes.isEmpty
          ? const Center(child: Text("Note Kosong"))
          : MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailPage(id: note.id!),
                      ),
                    );

                    _refreshNotes();
                  },
                  child: NoteCardWidget(note: note, index: index),
                );
              },
            ),
    );
  }
}
