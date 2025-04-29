import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/note.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  List<Note> _notes = [];
  String _currentFilter = 'All';

  NotesBloc() : super(NotesInitial()) {
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
    on<FilterNotes>(_onFilterNotes);
    on<ToggleNotePin>(_onToggleNotePin);
  }

  void _onAddNote(AddNote event, Emitter<NotesState> emit) {
    if (event.title.isEmpty || event.content.isEmpty) {
      emit(const NotesError('Title and content cannot be empty'));
      return;
    }

    final note = Note(
      title: event.title,
      content: event.content,
      category: event.category,
    );

    _notes.add(note);
    emit(NotesLoaded(
      notes: _getFilteredNotes(_currentFilter),
      currentFilter: _currentFilter,
    ));
  }

  void _onUpdateNote(UpdateNote event, Emitter<NotesState> emit) {
    final noteIndex = _notes.indexWhere((note) => note.id == event.note.id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = event.note;
      emit(NotesLoaded(
        notes: _getFilteredNotes(_currentFilter),
        currentFilter: _currentFilter,
      ));
    }
  }

  void _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) {
    _notes.removeWhere((note) => note.id == event.id);
    emit(NotesLoaded(
      notes: _getFilteredNotes(_currentFilter),
      currentFilter: _currentFilter,
    ));
  }

  void _onFilterNotes(FilterNotes event, Emitter<NotesState> emit) {
    _currentFilter = event.category;
    emit(NotesLoaded(
      notes: _getFilteredNotes(event.category),
      currentFilter: event.category,
    ));
  }

  void _onToggleNotePin(ToggleNotePin event, Emitter<NotesState> emit) {
    final noteIndex = _notes.indexWhere((note) => note.id == event.id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = _notes[noteIndex].copyWith(
        isPinned: !_notes[noteIndex].isPinned,
      );
      emit(NotesLoaded(
        notes: _getFilteredNotes(_currentFilter),
        currentFilter: _currentFilter,
      ));
    }
  }

  List<Note> _getFilteredNotes(String category) {
    List<Note> filteredNotes;
    if (category == 'All') {
      filteredNotes = List.from(_notes);
    } else {
      filteredNotes = _notes.where((note) => note.category == category).toList();
    }
    
    // Sort notes: pinned first, then by creation date (newest first)
    filteredNotes.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.createdAt.compareTo(a.createdAt);
    });
    
    return filteredNotes;
  }
} 