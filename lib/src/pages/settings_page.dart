import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("Settings")],
      ),
    );
  }
}
