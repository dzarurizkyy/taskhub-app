import 'package:taskhub_app/models/user.dart';

abstract class UserEvent {}

class LoginUser extends UserEvent {
  final String email;
  final String password;
  LoginUser(this.email, this.password);
}

class RegistrationUser extends UserEvent {
  final String name;
  final String gender;
  final String email;
  final String password;

  RegistrationUser(this.name, this.gender, this.email, this.password);
}

class UpdateProfile extends UserEvent {
  final User user;
  UpdateProfile(this.user);
}

class LoadCurrentUser extends UserEvent {}
class ResetUser extends UserEvent {}