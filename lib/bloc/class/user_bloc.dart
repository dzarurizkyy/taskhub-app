import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskhub_app/bloc/event/user_event.dart';
import 'package:taskhub_app/bloc/state/user_state.dart';
import 'package:taskhub_app/models/user.dart';
import 'package:taskhub_app/service/auth_service.dart';
import 'package:taskhub_app/service/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  final AuthService authService;

  UserBloc(this.userService, this.authService) : super(UserInitial()) {
    on<RegistrationUser>(_onRegistrationUser);
    on<LoginUser>(_onLoginUser);
    on<UpdateProfile>(_onUpdateProfile);
    on<LoadCurrentUser>(_onLoadCurrentUser);
    on<ResetUser>(_onResetUser);
  }

  Future<void> _onLoadCurrentUser(
      LoadCurrentUser event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString("user_id");

      if (userId != null) {
        final userMap = await userService.fetchUserById(userId);
        if (userMap != null) {
          final userData = User.fromFirestore(userMap);
          emit(UserLoaded(userData));
          return;
        }
      }
      emit(UserInitial());
    } catch (e) {
      emit(UserError("Failed to load current user"));
    }
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final userID = await authService.login(event.email, event.password);
      final userMap = await userService.fetchUserById(userID);

      if (userMap == null) {
        emit(UserError("User data not found in Firestore"));
        return;
      }

      final userData = User.fromFirestore(userMap);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", userID);

      emit(UserLoaded(userData));
    } catch (e) {
      emit(UserError("Failed to login. Please try again."));
    }
  }

  Future<void> _onRegistrationUser(
      RegistrationUser event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final userID = await authService.register(event.email, event.password);

      final now = DateTime.now();

      final user = User(
        id: userID,
        name: event.name,
        gender: event.gender,
        email: event.email,
        password: event.password,
        createdAt: now,
        updatedAt: now,
      );

      await userService.createUser(user);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", userID);
  
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
      await userService.updateUser(event.user);
      emit(UserLoaded(event.user));
    } catch (e) {
      emit(UserError("Failed to update profile. Please try again"));
    }
  }

  Future<void> _onResetUser(ResetUser event, Emitter<UserState> emit) async {
    emit(UserInitial());
  }
}
