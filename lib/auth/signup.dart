import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wage/auth/login.dart';
import 'package:wage/methods/common_methods.dart';
import 'package:wage/pages/home.dart';
import 'package:wage/widgets/loading_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {

  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phonenumberTextEditingController = TextEditingController();
  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvailable() {
    cMethods.checkConnectivity(context);
    signUpFormValidation();
  }

  signUpFormValidation() {
    if (usernameTextEditingController.text.trim().length < 3) {
      cMethods.displaySnackBar("User name must be atleast 4 characters", context);
    }
    else if (phonenumberTextEditingController.text.trim().length != 10) {
      cMethods.displaySnackBar("Phone number must be exactly 10 characters", context);
    }
    else if (!emailTextEditingController.text.contains('@')) {
      cMethods.displaySnackBar("Please write valid email address", context);
    }
    else if (passwordTextEditingController.text.trim().length < 8) {
      cMethods.displaySnackBar("Password must be at least 8 characters", context);
    }
    else {
      registerNewUser();
    }
  }

  registerNewUser() async {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) => LoadingDialog(messageText: "Registering your account...."),
    );

    final User? userFirebase = (
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(), 
        password: passwordTextEditingController.text.trim(),
      ).catchError((erroMsg) {
        Navigator.pop(context);
        cMethods.displaySnackBar(erroMsg.toString(), context);
      })
    ).user;
  
    if(!context.mounted) return;

    Navigator.pop(context);

    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    
    Map userDataMap = {
      "name": usernameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phone": phonenumberTextEditingController.text.trim(),
      "id": userFirebase.uid,
      "blockStatus": "no"
    };

    usersRef.set(userDataMap);
    Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.png"
              ),

              const Text(
                "Create an account",
                style: TextStyle(
                  fontSize: 26, 
                  fontWeight: FontWeight.bold,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "User Name",
                        labelStyle: TextStyle(
                          fontSize: 14, 
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                      ),
                    ),
                    
                    const SizedBox(height: 20,),

                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14, 
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                      ),
                    ),
                    
                    const SizedBox(height: 20,),

                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14, 
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                      ),
                    ),
                    
                    const SizedBox(height: 20,),
                    TextField(
                      controller: phonenumberTextEditingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                          fontSize: 14, 
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                      ),
                    ),
                    
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        checkIfNetworkIsAvailable();
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10)
                      ),
                      child: const Text(
                        "Sign Up"
                      ),
                    )
                  ],
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                }, 
                child: const Text(
                  "Already have an account? Login here",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

            ]
          ),
        ),
      )
    );
  }
}