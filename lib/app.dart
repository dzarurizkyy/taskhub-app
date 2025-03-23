import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskhub_app/pages/add_note_page.dart';

// import '../pages/login_page.dart';
import './providers/user_provider.dart';

class App extends StatelessWidget {
  final String flavor;
  const App({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TaskHub App",
        home: AddNotePage(),
      ),
    );
  }
}
