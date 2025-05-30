import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskhub_app/bloc/class/user_bloc.dart';
import 'package:taskhub_app/bloc/event/user_event.dart';
import 'package:taskhub_app/bloc/state/user_state.dart';
import 'package:taskhub_app/models/user.dart';
import 'package:taskhub_app/service/auth_service.dart';
import 'package:taskhub_app/service/user_service.dart';

class MockUserService extends Mock implements UserService {}

class MockAuthService extends Mock implements AuthService {}

class FakeUser extends Fake implements User {}

void main() {
  late UserBloc userBloc;
  late MockUserService mockUserService;
  late MockAuthService mockAuthService;

  setUpAll(() {
    registerFallbackValue(FakeUser());
  });

  setUp(() {
    mockUserService = MockUserService();
    mockAuthService = MockAuthService();
    userBloc = UserBloc(mockUserService, mockAuthService);
  });

  blocTest<UserBloc, UserState>(
    "emits [UserLoading, UserLoaded] when RegistrationUser succeds",
    build: () {
      when(() => mockAuthService.register(any(), any()))
          .thenAnswer((_) async => "user123");
      when(() => mockUserService.createUser(any()))
          .thenAnswer((_) async => Future.value());
      return userBloc;
    },
    act: (bloc) => bloc.add(
      RegistrationUser("John", "male", "john@gmail.com", "john123"),
    ),
    expect: () => [
      isA<UserLoading>(),
      isA<UserLoaded>().having((s) => s.user.name, "name", "John")
    ],
    verify: (_) {
      verify(() => mockAuthService.register("john@gmail.com", "john123"))
          .called(1);
      verify(() => mockUserService.createUser(any())).called(1);
    },
  );

  blocTest<UserBloc, UserState>(
    "emits [UserLoading. UserError] when RegistrationUser fails",
    build: () {
      when(() => mockAuthService.register(any(), any())).thenThrow(
        Exception("User registration failed"),
      );
      return userBloc;
    },
    act: (bloc) => bloc.add(
      RegistrationUser("John", "male", "john@gmai.com", "john123"),
    ),
    expect: () => [
      isA<UserLoading>(),
      isA<UserError>().having(
        (e) => e.message,
        "error message",
        contains("Failed to create user"),
      ),
    ],
    verify: (_) {
      verify(() => mockAuthService.register(any(), any())).called(1);
    },
  );

  blocTest<UserBloc, UserState>(
    "emits [UserLoading, UserLoaded] when LoginUser succeds",
    build: () {
      when(() => mockAuthService.login(any(), any()))
          .thenAnswer((_) async => "user123");
      when(() => mockUserService.fetchUserById("user123")).thenAnswer(
        ((_) async => {
              "id": "user123",
              "name": "John",
              "gender": "male",
              "email": "john@gmail.com",
              "password": "john123",
              "created_at": Timestamp.fromDate(DateTime.now()),
              "updated_at": Timestamp.fromDate(DateTime.now()),
            }),
      );
      return userBloc;
    },
    act: (bloc) => bloc.add(
      LoginUser("john@gmail.com", "john123"),
    ),
    expect: () => [
      isA<UserLoading>(),
      isA<UserLoaded>().having((state) => state.user.name, "name", "John")
    ],
    verify: (_) {
      verify(() => mockAuthService.login("john@gmail.com", "john123"))
          .called(1);
      verify(() => mockUserService.fetchUserById("user123")).called(1);
    },
  );

  blocTest<UserBloc, UserState>(
    "emits [UserLoading, UserError] when LoginUser fails",
    build: () {
      when(
        () => mockAuthService.login(any(), any()),
      ).thenThrow(Exception("User login failed"));
      return userBloc;
    },
    act: (bloc) => bloc.add(
      LoginUser("john@gmail.com", "john123"),
    ),
    expect: () => [
      isA<UserLoading>(),
      isA<UserError>().having(
        (e) => e.message,
        "error message",
        contains("Failed to login"),
      )
    ],
  );

  blocTest<UserBloc, UserState>(
    "emits [UserLoaded] when UpdateProfile succeds",
    build: () {
      when(() => mockUserService.updateUser(any())).thenAnswer(
        (_) async => true,
      );
      return userBloc;
    },
    act: (bloc) {
      final user = User(
        id: "user123",
        name: "Updated Name",
        gender: "male",
        email: "john@gmail.com",
        password: "john123",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      bloc.add(UpdateProfile(user));
    },
    expect: () =>
        [isA<UserLoaded>().having((s) => s.user.name, "name", "Updated Name")],
    verify: (_) {
      verify(() => mockUserService.updateUser(any())).called(1);
    },
  );

  blocTest<UserBloc, UserState>(
    "emits [UserError] when UpdateProfile fails",
    build: () {
      when(() => mockUserService.updateUser(any())).thenThrow(
        Exception("Updated user profile failed"),
      );
      return userBloc;
    },
    act: (bloc) {
      final user = User(
        id: "user123",
        name: "Updated Name",
        gender: "male",
        email: "john@gmail.com",
        password: "john123",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      bloc.add(UpdateProfile(user));
    },
    expect: () => [
      isA<UserError>().having(
        (e) => e.message,
        "error message",
        contains("Failed to update profile"),
      )
    ],
    verify: (_) {
      verify(() => mockUserService.updateUser(any())).called(1);
    },
  );
}
