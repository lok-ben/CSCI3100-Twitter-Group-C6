import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csci3100_twitter_project_c6/features/auth/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'Welcome',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _userId() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You are:'),
            _userId(),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
