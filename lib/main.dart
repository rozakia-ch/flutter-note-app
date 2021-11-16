import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/blocs/note_bloc.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/ui/pages/note_page.dart';

import 'hiveschema/note_schema.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  await Hive.openBox("Notes");
  runApp(BlocProvider(
    create: (context) => NoteBloc(NoteSchema()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(NoteInitialEvent());
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotePage(),
    );
  }
}
