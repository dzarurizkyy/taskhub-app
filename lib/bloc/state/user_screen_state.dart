abstract class UserScreenState {}

class UserScreenLoaded extends UserScreenState {
  final String gender;
  final bool isVisible;

  UserScreenLoaded({required this.gender, required this.isVisible});

  UserScreenLoaded copyWith({String? gender, bool? isVisible}) {
    return UserScreenLoaded(
      gender: gender ?? this.gender,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
