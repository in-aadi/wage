import 'package:flutter/material.dart';
import 'package:wage/auth/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Image.asset("assets/images/logo.png"),
          const Text(
            "Login as a User",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                
                TextField(
                  controller: _emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordTextEditingController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10)),
                  child: const Text("Login"),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => SignUpScreen()));
            },
            child: const Text(
              "Don't have an account? Sign Up here",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}