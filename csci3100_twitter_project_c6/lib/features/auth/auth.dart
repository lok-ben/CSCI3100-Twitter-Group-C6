import 'package:flutterfire_ui/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  SignInScreen build(BuildContext context) {
    return SignInScreen(
        subtitleBuilder: (context, action) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              action == AuthAction.signIn
                  ? 'Welcome! Please sign in to continue.'
                  : 'Welcome! Please create an account to continue',
            ),
          );
        },
        footerBuilder: (context, _) {
          return const Padding(
            padding: EdgeInsets.only(top: 16),
            child:
                Text('By signing in, you agree to our terms and conditions.'),
          );
        },
        sideBuilder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset('images/twitter.png'),
            ),
          );
        },
        headerBuilder: (context, constraints, _) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset('images/twitter.png'),
            ),
          );
        },
        providerConfigs: const [
          EmailProviderConfiguration(),
          GoogleProviderConfiguration(
            clientId:
                '332384831825-4cbkg08n8ogsqir6q60ess46sebgl947.apps.googleusercontent.com',
          ),
        ]);
  }
}
