import 'package:taskhub_app/models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class FormStatusUpdated extends UserState {
  final bool isFormValid;
  FormStatusUpdated(this.isFormValid);
}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
