import 'package:flutter/material.dart';
import 'package:foodapp/pages/login_page.dart';
import 'package:foodapp/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Starts from the right
            end: Offset.zero,              // Ends at the center
          ).animate(animation);

          return SlideTransition(
            position: slideAnimation,
            child: child,
          );
        },
        child: showLoginPage
            ? LoginPage(
                key: const ValueKey("LoginPage"),
                onToggle: togglePages,
              )
            : RegisterPage(
                key: const ValueKey("RegisterPage"),
                onRegisterTap: togglePages,
              ),
      ),
    );
  }
}
