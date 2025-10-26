import 'package:flutter/material.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Set up your profile"),
            Text("Choose a display name to get started"),

            Form(
              child: Column(
                children: [
                  Text("Display Name"),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
