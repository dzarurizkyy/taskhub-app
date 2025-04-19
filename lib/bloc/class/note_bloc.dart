import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:taskhub_app/bloc/event/note_event.dart';
import 'package:taskhub_app/bloc/state/note_state.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/service/note_service.dart';
import 'package:uuid/uuid.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteService _noteService = NoteService();
  final Uuid _uuid = Uuid();

  NoteBloc() : super(NoteInitial()) {
    on<FetchNotes>(_onFetchNotes);
    on<SearchNote>(_onSearchNote);
    on<AddNote>(_onAddNote);
    on<EditNote>(_onEditNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
  }

  Future<void> _onFetchNotes(FetchNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());

    try {
      final notes = await _noteService.fetchNote();
      emit(NoteLoaded(notes));
    } catch (e) {
      debugPrint("failed to fetch notes: $e");
      emit(NoteError("Failed to fetch notes. Please try again."));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    final currentState = state;

    if (currentState is NoteLoaded) {
      final newNote = Note(
        id: _uuid.v4(),
        title: event.title,
        description: event.description,
        date: event.date,
        priority: event.priority,
        section: "In Progress",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      try {
        await _noteService.createNote(newNote);
        emit(NoteLoaded([...currentState.notes, newNote]));
      } catch (e) {
        debugPrint("failed to create note: $e");
        emit(NoteError("Failed to take notes. Please try again."));
      }
    }
  }

  Future<void> _onSearchNote(SearchNote event, Emitter<NoteState> emit) async {
    final currentState = state;

    if (currentState is NoteLoaded) {
      final notes = currentState.notes
          .where((note) =>
              note.title.toLowerCase().contains(event.title.toLowerCase()))
          .toList();

      emit(NoteLoaded(notes));
    }
  }

  Future<void> _onEditNote(EditNote event, Emitter<NoteState> emit) async {
    final currentState = state;

    if (currentState is NoteLoaded) {
      final index =
          currentState.notes.indexWhere((note) => note.id == event.id);
      if (index != -1) {
        final updatedNote = currentState.notes[index].copyWith(
            id: event.id,
            title: event.title,
            description: event.description,
            date: event.date,
            priority: event.priority,
            section: currentState.notes[index].section,
            createdAt: currentState.notes[index].createdAt,
            updatedAt: DateTime.now());

        try {
          await _noteService.editNote(updatedNote);
          final updatedList = [...currentState.notes];
          updatedList[index] = updatedNote;
          emit(NoteLoaded(updatedList));
        } catch (e) {
          debugPrint("failed to edit note: $e");
          emit(NoteError("Failed to edit the note. Please try again."));
        }
      }
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    final currentState = state;

    if (currentState is NoteLoaded) {
      final index =
          currentState.notes.indexWhere((note) => note.id == event.id);
      if (index != -1) {
        final updatedNote = currentState.notes[index].copyWith(
          section: "Completed",
          updatedAt: DateTime.now(),
        );

        try {
          await _noteService.editNote(updatedNote);
          final updatedList = [...currentState.notes];
          updatedList[index] = updatedNote;
          emit(NoteLoaded(updatedList));
        } catch (e) {
          debugPrint("failed to update note: $e");
          emit(NoteError("Failed to update the note. Please try again."));
        }
      }
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    final currentState = state;

    if (currentState is NoteLoaded) {
      try {
        await _noteService.deleteNote(event.id);
        emit(
          NoteLoaded(
            currentState.notes.where((note) => note.id != event.id).toList(),
          ),
        );
      } catch (e) {
        debugPrint("failed to delete note: $e");
        emit(NoteError("Failed to delete note. Please try again."));
      }
    }
  }
}
