import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future deleteuser() async {
    user?.delete();
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

  Widget _removeUserButton() {
    return ElevatedButton(
      onPressed: deleteuser,
      child: const Text('Remove Account'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title()),
      drawer: SidebarX(
        controller: SidebarXController(
          selectedIndex: 0,
          extended: true,
        ),
        theme: SidebarXTheme(
            width: MediaQuery.of(context).size.width * 0.25,
            textStyle: const TextStyle(fontSize: 16)),
        items: const [
          SidebarXItem(icon: Icons.home, label: 'Home'),
          SidebarXItem(icon: Icons.search, label: 'Search'),
          SidebarXItem(icon: Icons.chat, label: 'Message'),
          SidebarXItem(icon: Icons.person, label: 'Portfolio'),
        ],
      ),
      body: Container(
        alignment: const Alignment(0, 0),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You are:'),
            _userId(),
            _signOutButton(),
            _removeUserButton(),
          ],
        ),
      ),
    );
  }
}
