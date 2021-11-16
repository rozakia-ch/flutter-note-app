part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

// initial event
class NoteInitialEvent extends NoteEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// add event
class NoteAddEvent extends NoteEvent {
  final String title, content;

  const NoteAddEvent({required this.title, required this.content});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// edit event
class NoteEditEvent extends NoteEvent {
  final String title, content;
  final int index;

  const NoteEditEvent({
    required this.title,
    required this.content,
    required this.index,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// delete event
class NoteDeleteEvent extends NoteEvent {
  final int index;

  const NoteDeleteEvent({required this.index});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
