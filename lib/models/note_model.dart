import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? content;

  NoteModel({this.title, this.content});
}
