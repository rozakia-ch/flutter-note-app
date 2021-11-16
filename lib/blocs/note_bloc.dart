import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:noteapp/hiveschema/note_schema.dart';
import 'package:noteapp/models/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteSchema _noteSchema;
  List<NoteModel> _notes = [];
  NoteBloc(this._noteSchema) : super(NoteInitial());
  // {
  //   on<NoteEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }
  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is NoteInitialEvent) {
      yield* _mapInitialEventToState();
    }

    if (event is NoteAddEvent) {
      yield* _mapNoteAddEventToState(
        title: event.title,
        content: event.content,
      );
    }

    if (event is NoteEditEvent) {
      yield* _mapNoteEditEventToState(
        title: event.title,
        content: event.content,
        index: event.index,
      );
    }

    if (event is NoteDeleteEvent) {
      yield* _mapNoteDeleteEventToState(index: event.index);
    }
  }

  // Stream Functions
  Stream<NoteState> _mapInitialEventToState() async* {
    yield NotesLoading();

    await _getNotes();

    yield YourNotesState(notes: _notes);
  }

  Stream<NoteState> _mapNoteAddEventToState({
    required String title,
    required String content,
  }) async* {
    yield NotesLoading();
    await _addToNotes(title: title, content: content);
    yield YourNotesState(notes: _notes);
  }

  Stream<NoteState> _mapNoteEditEventToState({
    required String title,
    required String content,
    required int index,
  }) async* {
    yield NotesLoading();
    await _updateNote(newTitle: title, newContent: content, index: index);
    yield YourNotesState(notes: _notes);
  }

  Stream<NoteState> _mapNoteDeleteEventToState({required int index}) async* {
    yield NotesLoading();
    await _removeFromNotes(index: index);
    _notes.sort((a, b) {
      var aDate = a.title;
      var bDate = b.title;
      return aDate!.compareTo(bDate!);
    });
    yield YourNotesState(notes: _notes);
  }

  // Helper Functions
  Future<void> _getNotes() async {
    await _noteSchema.getFullNote().then((value) {
      _notes = value;
    });
  }

  Future<void> _addToNotes({
    required String title,
    required String content,
  }) async {
    await _noteSchema.addToBox(NoteModel(title: title, content: content));
    await _getNotes();
  }

  Future<void> _updateNote({
    required int index,
    required String newTitle,
    required String newContent,
  }) async {
    await _noteSchema.updateNote(
      index,
      NoteModel(title: newTitle, content: newContent),
    );
    await _getNotes();
  }

  Future<void> _removeFromNotes({required int index}) async {
    await _noteSchema.deleteFromBox(index);
    await _getNotes();
  }
}
