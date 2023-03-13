import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csci3100_twitter_project_c6/features/auth/auth.dart';
import 'package:csci3100_twitter_project_c6/common/widgets/button.dart';
import 'package:csci3100_twitter_project_c6/common/widgets/textfield.dart';
import 'package:csci3100_twitter_project_c6/common/widgets/alert_dialog.dart';

enum AuthState {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthState _auth = AuthState.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final User? user = Auth().currentUser;
  String? errorMessage = '';

  Future<void> signIn() async {
    try {
      await Auth().signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        _showDialog(context, 'Error Occured',
            errorMessage.toString().split('Firebase: ')[1].split('(')[0]);
      });
    }
  }

  Future<void> signUp() async {
    try {
      await Auth().signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        _showDialog(context, 'Error Occured',
            errorMessage.toString().split('Firebase: ')[1].split('(')[0]);
      });
    }
  }

  Future<void> _showDialog(
      BuildContext context, String title, String content) async {
    continueCallBack() => {
          Navigator.of(context).pop(),
          // code on continue comes here
        };
    CustomBurryDialog alert = CustomBurryDialog(
      title: title,
      content: content,
      continueCallBack: continueCallBack,
    );

    await showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: _auth == AuthState.signup
                        ? colorScheme.primaryContainer
                        : colorScheme.onSecondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Radio(
                            value: AuthState.signup,
                            groupValue: _auth,
                            onChanged: (AuthState? val) {
                              setState(() {
                                _auth = val!;
                              });
                            },
                          ),
                        ),
                        if (_auth == AuthState.signup)
                          Form(
                              key: _signUpFormKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: _emailController,
                                    hintText: 'User Email',
                                  ),
                                  CustomTextField(
                                    controller: _nameController,
                                    hintText: 'User Name',
                                  ),
                                  CustomTextField(
                                    controller: _passwordController,
                                    hintText: 'User Password',
                                    password: true,
                                  ),
                                  CustomButton(
                                      text: 'Sign Up',
                                      onClick: () => {
                                            if (_signUpFormKey.currentState!
                                                .validate())
                                              {signUp()}
                                          })
                                ],
                              )),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: _auth == AuthState.signin
                        ? colorScheme.primaryContainer
                        : colorScheme.onSecondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      ListTile(
                        title: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Radio(
                          value: AuthState.signin,
                          groupValue: _auth,
                          onChanged: (AuthState? val) {
                            setState(() {
                              _auth = val!;
                            });
                          },
                        ),
                      ),
                      if (_auth == AuthState.signin)
                        Form(
                            key: _signInFormKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: _emailController,
                                  hintText: 'User Email',
                                ),
                                CustomTextField(
                                  controller: _passwordController,
                                  hintText: 'User Password',
                                  password: true,
                                ),
                                CustomButton(
                                    text: 'Submit',
                                    onClick: () => {
                                          if (_signInFormKey.currentState!
                                              .validate())
                                            {signIn()}
                                        })
                              ],
                            )),
                    ]),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
