import 'package:equatable/equatable.dart';
import '../models/note.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;
  final String currentFilter;

  const NotesLoaded({
    required this.notes,
    this.currentFilter = 'All',
  });

  @override
  List<Object> get props => [notes, currentFilter];
}

class NotesError extends NotesState {
  final String message;

  const NotesError(this.message);

  @override
  List<Object> get props => [message];
} 