abstract class UserScreenEvent {}

class ChangeVisiblePassword extends UserScreenEvent {
  final bool isVisible;
  ChangeVisiblePassword(this.isVisible);
}

class ChangeGender extends UserScreenEvent {
  final String gender;
  ChangeGender(this.gender);
}
