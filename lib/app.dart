import 'package:flutter/material.dart';
import 'package:taskhub_app/pages/login_page.dart';
import 'package:taskhub_app/routes/routes.dart';

final appRouter = AppRouter();

class App extends StatelessWidget {
  final String flavor;
  const App({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TaskHub App",
      onGenerateInitialRoutes: (initialRoute) => [
        appRouter.generateRoute(
          RouteSettings(name: LoginPage.routeName),
        ),
      ],
      onGenerateRoute: appRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
