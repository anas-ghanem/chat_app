import 'package:chat_app/conset.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/regster.dart';
import 'package:chat_app/widgets.dart/button.dart';
import 'package:chat_app/widgets.dart/testfild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({super.key});
  String id = "Login_page";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String email = "";

  String password = "";

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimarykey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Spacer(flex: 1),
              Image.asset("assets/images/scholar.png"),
              Text(
                "scholer chat",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: "Pacifico",
                ),
              ),
              Spacer(flex: 2),
              Row(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 27, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 12),
              custom_textfild(
                hinttext: "Email",
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 12),
              custom_textfild(
                hinttext: "password",

                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 17),
              custom_button(
                text: "Login",
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    isloading = true;
                    setState(() {});
                    try {
                      await Login();
                      showsnackbar(context, massage: "Login success");
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        ChatPage().id,
                        (route) => false,arguments: email,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "weak-password") {
                        showsnackbar(
                          context,
                          massage: "The password provided is too weak.",
                        );
                      } else if (e.code == "email-already-in-use") {
                        showsnackbar(
                          context,
                          massage: "The account already exists for that email.",
                        );
                      }

                      showsnackbar(context, massage: e.code);
                    }
                    isloading = false;
                    setState(() {});
                  }
                },
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "dont an have account?",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Regster().id,
                        arguments: email,
                      );
                    },
                    child: Text(
                      " regster ",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  void showsnackbar(BuildContext context, {required String massage}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(massage)));
  }

  Future<void> Login() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
