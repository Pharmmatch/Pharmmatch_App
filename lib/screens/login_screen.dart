import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              child: Theme(
                data: ThemeData(
                    primaryColor: Colors.black,
                    inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ))),
                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  child: const Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'password'),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
