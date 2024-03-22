import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:stocks_tracking_app/providers/state_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'login_screen';
  static const String link = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isLogin = false;
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    isLoading = false;
    isLogin = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showCustomSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(label: 'Ok', onPressed: () {}),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Stocks Tracking App',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Image(
                image: AssetImage('assets/images/logo_app.png'),
                height: 200,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
              const SizedBox(height: 20.0),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 10.0),
              isLoading
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                    )
                  : FilledButton.icon(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await context.read<StateProvider>().doLogin(
                            emailController.text.trim(),
                            passwordController.text);
                        setState(() {
                          isLoading = false;
                        });
                        if (!context.mounted) return;
                        if (context.read<StateProvider>().userData.isLogin) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context.go('/');
                          });
                        } else {
                          showCustomSnackbar(
                              context,
                              context
                                  .read<StateProvider>()
                                  .currentRequestStatus
                                  .details);
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: const Text("Login")),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
