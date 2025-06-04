import 'package:bloc/bloc.dart';
import 'package:taskhub_app/bloc/event/note_event.dart';
import 'package:taskhub_app/bloc/state/note_state.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/service/note_service.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteService noteService;

  NoteBloc(this.noteService) : super(NoteInitial()) {
    on<FetchNotes>(_onFetchNotes);
    on<FetchNoteById>(_onFetchNoteById);
    on<SearchNote>(_onSearchNote);
    on<AddNote>(_onAddNote);
    on<EditNote>(_onEditNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
  }

  Future<void> _onFetchNotes(FetchNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());

    try {
      final notes = await noteService.fetchNote();
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError("Failed to fetch notes. Please try again. $e"));
    }
  }

  Future<void> _onFetchNoteById(
      FetchNoteById event, Emitter<NoteState> emit) async {
    emit(NoteLoading());

    try {
      final note = await noteService.fetchNoteById(event.id);
      final noteData = Note.fromFirestore(note);
      emit(NoteLoadedById(noteData));
    } catch (e) {
      emit(NoteError("Failed to fetch note by id. Please try again. $e"));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    final currentState = state;

    if (currentState is NoteLoaded) {
      try {
        final docId = await noteService.createNote(
            event.title, event.description, event.date, event.priority);

        if (docId != null) {
          final newNote =
              Note.fromFirestore(await noteService.fetchNoteById(docId));

          emit(NoteLoaded([...currentState.notes, newNote]));
        } else {
          emit(NoteError("Failed to create notes. Please try again."));
        }
      } catch (e) {
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

    if (currentState is NoteLoadedById) {
      final updatedNote = currentState.note.copyWith(
        id: event.id,
        title: event.title,
        description: event.description,
        date: event.date,
        priority: event.priority,
        section: currentState.note.section,
        createdAt: currentState.note.createdAt,
        updatedAt: DateTime.now(),
      );

      try {
        await noteService.editNote(updatedNote);
        final note = await noteService.fetchNoteById(event.id);
        emit(NoteLoadedById(Note.fromFirestore(note)));
      } catch (e) {
        emit(NoteError("Failed to edit the note. Please try again."));
      }
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    final currentState = state;

    if (currentState is NoteLoadedById) {
      final updatedNote = currentState.note.copyWith(
        section: "Completed",
        updatedAt: DateTime.now(),
      );

      try {
        await noteService.editNote(updatedNote);
        final note = await noteService.fetchNoteById(event.id);
        emit(NoteLoadedById(Note.fromFirestore(note)));
      } catch (e) {
        emit(NoteError("Failed to update the note. Please try again."));
      }
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    final currentState = state;

    if (currentState is NoteLoadedById) {
      try {
        await noteService.deleteNote(event.id);
        await noteService.fetchNote();
      } catch (e) {
        emit(NoteError("Failed to delete note. Please try again."));
      }
    }
  }
}
