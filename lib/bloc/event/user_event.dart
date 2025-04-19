abstract class UserEvent {}

class UpdateFormStatus extends UserEvent {
  final String email;
  final String password;

  UpdateFormStatus(this.email, this.password);
}

class LoginUser extends UserEvent {
  final String email;
  final String password;

  LoginUser(this.email, this.password);
}
