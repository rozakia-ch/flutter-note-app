import 'package:noteapp/hiveschema/note_schema.dart';
import 'package:noteapp/models/note_model.dart';

class NoteRepository {
  final NoteSchema noteSchema;
  NoteRepository(this.noteSchema);

  // Helper Functions
  Future getNotes() async {
    late List<NoteModel> _notes = [];
    await noteSchema.getFullNote().then((value) {
      _notes = value;
    });
    return _notes;
  }

  Future<void> addToNotes({
    required String title,
    required String content,
  }) async {
    await noteSchema.addToBox(NoteModel(title: title, content: content));
    await getNotes();
  }

  Future<void> updateNote({
    required int index,
    required String newTitle,
    required String newContent,
  }) async {
    await noteSchema.updateNote(
      index,
      NoteModel(title: newTitle, content: newContent),
    );
    await getNotes();
  }

  Future<void> removeFromNotes({required int index}) async {
    await noteSchema.deleteFromBox(index);
    await getNotes();
  }
}
