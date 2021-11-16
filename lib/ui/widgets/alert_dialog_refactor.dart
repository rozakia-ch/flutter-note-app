import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/blocs/note_bloc.dart';

class AlertDialogRefactor extends StatelessWidget {
  final int index;
  const AlertDialogRefactor({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete?',
        style: TextStyle(color: Color(0xFF49565e)),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
          ),
          child: const Text(
            'YES',
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {
            BlocProvider.of<NoteBloc>(context).add(
              NoteDeleteEvent(index: index),
            );
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFFFFFFFF),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'CANCEL',
            style: TextStyle(color: Color(0xFF49565e)),
          ),
        )
      ],
    );
  }
}
