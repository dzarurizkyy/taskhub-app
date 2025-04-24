import 'package:bloc/bloc.dart';
import 'package:taskhub_app/bloc/event/note_screen_event.dart';
import 'package:taskhub_app/bloc/state/note_screen_state.dart';

class NoteScreenBloc extends Bloc<NoteScreenEvent, NoteScreenState> {
  NoteScreenBloc(
      {required String initialPriority, required initialButtonStatus})
      : super(
          NoteScreenLoaded(
              priority: initialPriority, buttonStatus: initialButtonStatus),
        ) {
    on<ChangePriority>(_onChangePriority);
    on<ChangeButtonStatus>(_onChangeButtonStatus);
  }

  void _onChangeButtonStatus(
      ChangeButtonStatus event, Emitter<NoteScreenState> emit) {
    if (state is NoteScreenLoaded) {
      final currentState = state as NoteScreenLoaded;
      bool buttonStatus = event.title.isNotEmpty &&
          event.description.isNotEmpty &&
          event.date.isNotEmpty &&
          event.time.isNotEmpty;
      emit(currentState.copyWith(buttonStatus: buttonStatus));
    }
  }

  void _onChangePriority(ChangePriority event, Emitter<NoteScreenState> emit) {
    if (state is NoteScreenLoaded) {
      final currentState = state as NoteScreenLoaded;
      emit(currentState.copyWith(priority: event.priority));
    }
  }
}
