import 'package:bloc/bloc.dart';
import 'package:taskhub_app/bloc/event/user_event.dart';
import 'package:taskhub_app/bloc/state/user_state.dart';
import 'package:taskhub_app/service/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = UserService();

  UserBloc() : super(UserInitial()) {
    on<UpdateFormStatus>(_onUpdateFormStatus);
    on<LoginUser>(_onLoginUser);
    on<UpdateProfile>(_onUpdateProfile);
  }

  void _onUpdateFormStatus(UpdateFormStatus event, Emitter<UserState> emit) {
    bool isFormValid = event.email.isNotEmpty && event.password.isNotEmpty;
    emit(FormStatusUpdated(isFormValid));
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final user = await _userService.loginUser(event.email, event.password);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError("Failed to login. Please try again."));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<UserState> emit,
  ) async {
    try {
      final updatedUser = await _userService.updateUserProfile(event.user);
      emit(UserLoaded(updatedUser));
    } catch (e) {
      emit(UserError("Failed to update profile. Please try again"));
    }
  }
}
