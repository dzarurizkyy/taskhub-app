import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/models/user.dart' as local_user;
import 'package:taskhub_app/pages/home_page.dart';
import 'package:taskhub_app/pages/login_page.dart';
import 'package:taskhub_app/routes/routes.dart';
import 'package:taskhub_app/service/auth_service.dart';

class App extends StatelessWidget {
  final String flavor;
  final AuthService authService;
  final AppRouter appRouter;

  App({super.key, required this.flavor})
      : authService = AuthService(),
        appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<local_user.User?>(
      stream: authService.streamAuthStatus,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            title: "TaskHub App",
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            debugShowCheckedModeBanner: false,
          );
        }

        final homeWidget = snapshot.data != null
            ? MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: appRouter.note),
                  BlocProvider.value(value: appRouter.user),
                ],
                child: HomePage(),
              )
            : BlocProvider.value(
                value: appRouter.user,
                child: LoginPage(),
              );

        return MaterialApp(
          title: "TaskHub App",
          home: homeWidget,
          onGenerateRoute: appRouter.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
