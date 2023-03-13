import 'package:flutter/material.dart';
import 'dart:ui';

class CustomBurryDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback continueCallBack;
  const CustomBurryDialog({
    super.key,
    required this.title,
    required this.content,
    required this.continueCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Continue"),
              onPressed: () {
                continueCallBack();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
