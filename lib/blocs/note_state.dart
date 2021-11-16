part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

// loading
class NotesLoading extends NoteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// edit notes
class EditNotesState extends NoteState {
  final NoteModel note;

  const EditNotesState({required this.note});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//  your notes
class YourNotesState extends NoteState {
  final List<NoteModel> notes; // get all notes

  const YourNotesState({required this.notes});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// new note
class NewNoteState extends NoteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
