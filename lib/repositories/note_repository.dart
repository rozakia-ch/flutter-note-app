import 'package:noteapp/hiveschema/note_schema.dart';
import 'package:noteapp/models/note_model.dart';

class NoteRepository {
  final NoteSchema _noteSchema = NoteSchema();

  // Helper Functions
  Future<void> getNotes() async {
    // late List<NoteModel> _notes = [];
    await _noteSchema.getFullNote().then((value) {
      // _notes = value;
      return value;
    });
  }

  Future<void> addToNotes({
    required String title,
    required String content,
  }) async {
    await _noteSchema.addToBox(NoteModel(title: title, content: content));
    await getNotes();
  }

  Future<void> updateNote({
    required int index,
    required String newTitle,
    required String newContent,
  }) async {
    await _noteSchema.updateNote(
      index,
      NoteModel(title: newTitle, content: newContent),
    );
    await getNotes();
  }

  Future<void> removeFromNotes({required int index}) async {
    await _noteSchema.deleteFromBox(index);
    await getNotes();
  }
}
