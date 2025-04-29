import 'package:equatable/equatable.dart';
import '../models/note.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class AddNote extends NotesEvent {
  final String title;
  final String content;
  final String category;

  const AddNote({
    required this.title,
    required this.content,
    required this.category,
  });

  @override
  List<Object> get props => [title, content, category];
}

class UpdateNote extends NotesEvent {
  final Note note;

  const UpdateNote(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NotesEvent {
  final String id;

  const DeleteNote(this.id);

  @override
  List<Object> get props => [id];
}

class FilterNotes extends NotesEvent {
  final String category;

  const FilterNotes(this.category);

  @override
  List<Object> get props => [category];
}

class ToggleNotePin extends NotesEvent {
  final String id;

  const ToggleNotePin(this.id);

  @override
  List<Object> get props => [id];
} 