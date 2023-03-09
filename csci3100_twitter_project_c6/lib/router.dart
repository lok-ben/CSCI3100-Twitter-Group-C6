import 'package:csci3100_twitter_project_c6/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:csci3100_twitter_project_c6/homepage.dart';
import 'package:csci3100_twitter_project_c6/features/auth/auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
