import 'package:bloc/bloc.dart';
import 'package:taskhub_app/bloc/event/user_screen_event.dart';
import 'package:taskhub_app/bloc/state/user_screen_state.dart';

class UserScreenBloc extends Bloc<UserScreenEvent, UserScreenState> {
  UserScreenBloc({required String initialGender, required bool initialVisible})
      : super(
          UserScreenLoaded(
            gender: initialGender,
            isVisible: initialVisible,
          ),
        ) {
    on<ChangeVisiblePassword>(_onChangeVisiblePassword);
    on<ChangeGender>(_onChangeGender);
  }

  void _onChangeVisiblePassword(
      ChangeVisiblePassword event, Emitter<UserScreenState> emit) {
    if (state is UserScreenLoaded) {
      final currentState = state as UserScreenLoaded;
      emit(currentState.copyWith(isVisible: event.isVisible));
    }
  }

  void _onChangeGender(ChangeGender event, Emitter<UserScreenState> emit) {
    if (state is UserScreenLoaded) {
      final currentState = state as UserScreenLoaded;
      emit(currentState.copyWith(gender: event.gender));
    }
  }
}
