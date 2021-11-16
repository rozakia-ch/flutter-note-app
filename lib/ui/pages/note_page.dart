import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/blocs/note_bloc.dart';
import 'package:noteapp/ui/pages/note_form.dart';
import 'package:noteapp/ui/widgets/alert_dialog_refactor.dart';
import 'package:noteapp/ui/widgets/note_card.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.95),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const NoteForm(
                  newNote: true,
                  index: 1,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Note App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // define all state and rebuild ui
            BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state is NoteInitial) {
                  return Container();
                }
                if (state is YourNotesState) {
                  return NoteGrid(state: state);
                }
                if (state is NotesLoading) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NoteGrid extends StatelessWidget {
  final YourNotesState state;
  const NoteGrid({Key? key, required this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: state.notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        mainAxisSpacing: 8,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        final note = state.notes[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return NoteForm(
                    note: note,
                    index: index,
                    newNote: false,
                  );
                },
              ),
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialogRefactor(index: index),
            );
          },
          child: NoteCard(
            title: note.title!,
            content: note.content!,
          ),
        );
      },
    );
  }
}
