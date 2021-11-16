import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/blocs/note_bloc.dart';
import 'package:noteapp/models/note_model.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({
    Key? key,
    required this.newNote,
    this.note,
    required this.index,
  }) : super(key: key);
  final bool newNote;
  final NoteModel? note;
  final int index;

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  @override
  Widget build(BuildContext context) {
    String? title = widget.note != null ? widget.note!.title : "";
    String? content = widget.note != null ? widget.note!.content : "";
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController(text: title);
    final _contentController = TextEditingController(text: content);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.newNote ? "Add Note" : "Edit Note"),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.newNote
                    ? BlocProvider.of<NoteBloc>(context).add(
                        NoteAddEvent(
                          title: _titleController.text,
                          content: _contentController.text,
                        ),
                      )
                    : BlocProvider.of<NoteBloc>(context).add(
                        NoteEditEvent(
                          title: _titleController.text,
                          content: _contentController.text,
                          index: widget.index,
                        ),
                      );
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                NoteTitle(titleController: _titleController),
                const SizedBox(height: 20),
                NoteBody(contentController: _contentController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoteTitle extends StatelessWidget {
  final TextEditingController _titleController;

  const NoteTitle({
    Key? key,
    required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the note title';
        }
        return null;
      },
      controller: _titleController,
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: Colors.black38),
        border: OutlineInputBorder(),
        labelText: 'Note Title',
      ),
    );
  }
}

class NoteBody extends StatelessWidget {
  const NoteBody({
    Key? key,
    required TextEditingController contentController,
  })  : _contentController = contentController,
        super(key: key);

  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the note body!';
        }
        return null;
      },
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
      maxLines: null,
      minLines: 3,
      controller: _contentController,
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: Colors.black38),
        border: OutlineInputBorder(),
        labelText: 'Note Body',
      ),
    );
  }
}
