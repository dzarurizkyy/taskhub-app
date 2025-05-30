import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/event/note_event.dart';
import 'package:taskhub_app/bloc/state/note_state.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/service/note_service.dart';

class MockNoteService extends Mock implements NoteService {}

class FakeNote extends Fake implements Note {}

void main() {
  late NoteBloc noteBloc;
  late MockNoteService mockNoteService;

  String cleanDateString(String input) {
    return input.replaceAll('\u202F', ' ');
  }

  final DateFormat format = DateFormat("MMMM d, y 'at' hh:mm:ss a 'UTC'Z");
  final DateTime parsedDate =
      format.parse(cleanDateString("June 1, 2025 at 12:00:00 AM UTC+7"));
  final DateTime parsedCreatedAt =
      format.parse(cleanDateString("May 28, 2025 at 9:28:02 PM UTC+7"));

  final mockNotes = [
    Note(
      id: "QZ4gAvpR13oign6yi9tI",
      title: "This is title",
      description: "This is description",
      date: parsedDate,
      priority: "Low",
      section: "In Progress",
      createdAt: parsedCreatedAt,
      updatedAt: parsedCreatedAt,
    )
  ];

  setUpAll(() {
    registerFallbackValue(FakeNote());
  });

  setUp(() {
    mockNoteService = MockNoteService();
    noteBloc = NoteBloc(mockNoteService);
  });

  tearDown(() async {
    await noteBloc.close();
  });

  blocTest<NoteBloc, NoteState>(
    "emits [NoteLoading, NoteLoaded] when fetchNote succeeds",
    build: () {
      when(
        () => mockNoteService.fetchNote(),
      ).thenAnswer(
        (_) async => mockNotes,
      );
      return noteBloc;
    },
    act: (bloc) => bloc.add(FetchNotes()),
    expect: () => [
      isA<NoteLoading>(),
      isA<NoteLoaded>().having((s) => s.notes.length, "notes length", 1),
    ],
    verify: (_) {
      verify(() => mockNoteService.fetchNote()).called(1);
    },
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteLoading, NoteError] when fetchNote fails",
    build: () {
      when(
        () => mockNoteService.fetchNote(),
      ).thenThrow(
        Exception("Fetch note failed"),
      );
      return noteBloc;
    },
    act: (bloc) => bloc.add(FetchNotes()),
    expect: () => [
      isA<NoteLoading>(),
      isA<NoteError>().having(
        (e) => e.message,
        "error message",
        contains("Failed to fetch notes"),
      ),
    ],
    verify: (_) {
      verify(() => mockNoteService.fetchNote()).called(1);
    },
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteLoaded] with new note added when AddNote is successful",
    build: () {
      when(() => mockNoteService.createNote(any())).thenAnswer(
        (_) async => "new_id",
      );
      return noteBloc;
    },
    seed: () => NoteLoaded(mockNotes),
    act: (bloc) => bloc.add(
      AddNote("New Note Title", "New Note Description", parsedDate, "Medium"),
    ),
    expect: () => [
      isA<NoteLoaded>().having((s) => s.notes.length, "notes length", 2).having(
          (s) => s.notes.last.title, "last note title", "New Note Title"),
    ],
    verify: (_) {
      verify(() => mockNoteService.createNote(any())).called(1);
    },
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteError] when createNote returns null",
    build: () {
      when(
        () => mockNoteService.createNote(any()),
      ).thenAnswer(
        (_) async => null,
      );
      return noteBloc;
    },
    seed: () => NoteLoaded([]),
    act: (bloc) => bloc.add(
      AddNote("New Note Title", "New Note Description", parsedDate, "Medium"),
    ),
    expect: () => [
      isA<NoteError>().having(
        (e) => e.message,
        "error message",
        contains("Failed to create notes"),
      )
    ],
    verify: (_) {
      verify(() => mockNoteService.createNote(any())).called(1);
    },
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteError] when createNote throws an exception",
    build: () {
      when(
        () => mockNoteService.createNote(any()),
      ).thenThrow(
        Exception("Create note failed"),
      );
      return noteBloc;
    },
    seed: () => NoteLoaded([]),
    act: (bloc) => bloc.add(
      AddNote("New Note Title", "New Note Description", parsedDate, "Medium"),
    ),
    expect: () => [
      isA<NoteError>().having(
        (e) => e.message,
        "error message",
        contains("Failed to take notes"),
      )
    ],
    verify: (_) {
      verify(() => mockNoteService.createNote(any())).called(1);
    },
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteLoaded] with filtered notes when SearchNote is called",
    build: () => noteBloc,
    seed: () => NoteLoaded(
      [
        Note(
          id: "1",
          title: "Meeting with client",
          description: "Discuss the new project",
          date: DateTime.now(),
          priority: "High",
          section: "Completed",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Note(
          id: "2",
          title: "Grocery shopping",
          description: "Buy ingredients for dinner",
          date: DateTime.now(),
          priority: "Medium",
          section: "In Progress",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ],
    ),
    act: (bloc) => bloc.add(SearchNote("meeting")),
    expect: () => [
      isA<NoteLoaded>()
          .having(
            (s) => s.notes.length,
            "filtered notes length",
            1,
          )
          .having(
            (s) => s.notes.first.title,
            "note title",
            "Meeting with client",
          ),
    ],
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteLoaded] with empty list when no notes match search",
    build: () => noteBloc,
    seed: () => NoteLoaded(
      [
        Note(
          id: "1",
          title: "Meeting with client",
          description: "Discuss the new project",
          date: DateTime.now(),
          priority: "High",
          section: "Completed",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Note(
          id: "2",
          title: "Grocery shopping",
          description: "Buy ingredients for dinner",
          date: DateTime.now(),
          priority: "Medium",
          section: "In Progress",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ],
    ),
    act: (bloc) => bloc.add(SearchNote("Workshop")),
    expect: () => [
      isA<NoteLoaded>().having((state) => state.notes.length, "notes length", 0)
    ],
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteLoaded] with updated note when EditNote is successful",
    build: () {
      when(() => mockNoteService.editNote(any())).thenAnswer((_) async => true);
      return noteBloc;
    },
    seed: () => NoteLoaded(
      [
        Note(
          id: "1",
          title: "Old Title",
          description: "Old Description",
          date: DateTime(2025, 6, 01),
          priority: "Low",
          section: "In Progress",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
      ],
    ),
    act: (bloc) => bloc.add(
      EditNote(
        "1",
        "Updated Title",
        "Updated Description",
        DateTime(2025, 6, 30),
        "Medium",
        "In Progress",
        DateTime.now(),
        DateTime.now(),
      ),
    ),
    expect: () => [
      isA<NoteLoaded>()
          .having((s) => s.notes.first.title, "title", "Updated Title")
          .having((s) => s.notes.first.description, "description",
              "Updated Description")
          .having((s) => s.notes.first.date, "date", DateTime(2025, 6, 30))
          .having((s) => s.notes.first.priority, "priority", "Medium")
    ],
    verify: (_) {
      verify(() => mockNoteService.editNote(any())).called(1);
    },
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteError] when editNote throws an exception",
    build: () {
      when(() => mockNoteService.editNote(any())).thenThrow(
        Exception("Edit note failed"),
      );
      return noteBloc;
    },
    seed: () => NoteLoaded(
      [
        Note(
          id: "1",
          title: "Old Title",
          description: "Old Description",
          date: DateTime(2025, 6, 01),
          priority: "Low",
          section: "In Progress",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
      ],
    ),
    act: (bloc) => bloc.add(
      EditNote(
        "1",
        "Updated Title",
        "Updated Description",
        DateTime(2025, 6, 30),
        "Medium",
        "In Progress",
        DateTime.now(),
        DateTime.now(),
      ),
    ),
    expect: () => [
      isA<NoteError>().having(
        (e) => e.message,
        "error message",
        contains("Failed to edit the note"),
      )
    ],
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteLoaded] with update note section when UpdateNote is successful",
    build: () {
      when(() => mockNoteService.editNote(any())).thenAnswer(
        (_) async => true,
      );
      return noteBloc;
    },
    seed: () => NoteLoaded(
      [
        Note(
          id: "1",
          title: "This is title",
          description: "This is description",
          date: DateTime(2025, 5, 30),
          priority: "Medium",
          section: "In Progress",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ],
    ),
    act: (bloc) => bloc.add(UpdateNote("1")),
    expect: () => [
      isA<NoteLoaded>().having(
        (s) => s.notes.first.section,
        "section",
        "Completed",
      )
    ],
    verify: (_) {
      verify(() => mockNoteService.editNote(any())).called(1);
    },
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteError] when UpdateNote fails",
    build: () {
      when(() => mockNoteService.editNote(any())).thenThrow(
        Exception("Update note failed"),
      );
      return noteBloc;
    },
    seed: () => NoteLoaded(
      [
        Note(
          id: "1",
          title: "This is title",
          description: "This is description",
          date: DateTime(2025, 5, 30),
          priority: "Medium",
          section: "In Progress",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ],
    ),
    act: (bloc) => bloc.add(UpdateNote("1")),
    expect: () => [
      isA<NoteError>().having(
        (e) => e.message,
        "error message",
        contains("Failed to update the note"),
      ),
    ],
    verify: (_) {
      verify(() => mockNoteService.editNote(any())).called(1);
    },
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteLoaded] with deleted note when DeleteNote is successful",
    build: () {
      when(() => mockNoteService.deleteNote((any()))).thenAnswer(
        (_) async => true,
      );
      return noteBloc;
    },
    seed: () => NoteLoaded(
      [
        Note(
          id: "1",
          title: "Note to delete",
          description: "This note wil be deleted",
          date: DateTime(2025, 5, 30),
          priority: "High",
          section: "In Progress",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Note(
          id: "2",
          title: "Other note",
          description: "This one stays",
          date: DateTime(2025, 5, 30),
          priority: "Low",
          section: "Completed",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
      ],
    ),
    act: (bloc) => bloc.add(DeleteNote("1")),
    expect: () => [
      isA<NoteLoaded>()
          .having((s) => s.notes.length, "notes length", 1)
          .having((s) => s.notes.first.id, "remaining note id", "2"),
    ],
    verify: (_) {
      verify(() => mockNoteService.deleteNote("1")).called(1);
    },
  );

  blocTest<NoteBloc, NoteState>(
    "emits [NoteLoaded] when DeleteNote throws an exception",
    build: () {
      when(() => mockNoteService.deleteNote("1")).thenThrow(
        Exception("Delete note failed"),
      );
      return noteBloc;
    },
    seed: () => NoteLoaded(
      [
        Note(
          id: "1",
          title: "Note to delete",
          description: "This note wil be deleted",
          date: DateTime(2025, 5, 30),
          priority: "High",
          section: "In Progress",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Note(
          id: "2",
          title: "Other note",
          description: "This one stays",
          date: DateTime(2025, 5, 30),
          priority: "Low",
          section: "Completed",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
      ],
    ),
    act: (bloc) => bloc.add(DeleteNote("1")),
    expect: () => [
      isA<NoteError>().having(
        (e) => e.message,
        "error message",
        contains("Failed to delete note"),
      )
    ],
  );
}
