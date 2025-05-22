import 'package:bloc/bloc.dart';
import 'package:taskhub_app/bloc/event/user_event.dart';
import 'package:taskhub_app/bloc/state/user_state.dart';
import 'package:taskhub_app/models/user.dart';
import 'package:taskhub_app/service/auth_service.dart';
import 'package:taskhub_app/service/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  UserBloc() : super(UserInitial()) {
    on<UpdateFormStatus>(_onUpdateFormStatus);
    on<RegistrationUser>(_onRegistrationUser);
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
      final userID = await _authService.login(event.email, event.password);
      final userMap = await _userService.fetchUserById(userID);

      if (userMap == null) {
        emit(UserError("User data not found in Firestore"));
        return;
      }

      final userData = User.fromFirestore(userMap);
      emit(UserLoaded(userData));
    } catch (e) {
      emit(UserError("Failed to login. Please try again."));
    }
  }

  Future<void> _onRegistrationUser(
      RegistrationUser event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final id = await AuthService().register(event.email, event.password);

      final now = DateTime.now();

      final user = User(
        id: id,
        name: event.name,
        gender: event.gender,
        email: event.email,
        password: event.password,
        createdAt: now,
        updatedAt: now,
      );

      await _userService.createUser(user);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError("Failed to create user. Please try again."));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<UserState> emit,
  ) async {
    try {
      await _userService.updateUser(event.user);
      emit(UserLoaded(event.user));
    } catch (e) {
      emit(UserError("Failed to update profile. Please try again"));
    }
  }
}
