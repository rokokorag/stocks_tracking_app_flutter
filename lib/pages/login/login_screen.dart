import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Stocks Tracking App'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/images/logo_app.png')),
            Text('Login', style: theme.textTheme.titleLarge),
            const SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10.0),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 10.0),
            FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.login),
                label: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
