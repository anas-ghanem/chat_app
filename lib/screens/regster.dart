import 'package:chat_app/conset.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/widgets.dart/button.dart';
import 'package:chat_app/widgets.dart/testfild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Regster extends StatefulWidget {
  Regster({super.key});
  String id = "regster_page";

  @override
  State<Regster> createState() => _RegsterState();
}

class _RegsterState extends State<Regster> {
  String email = "";

  String password = "";

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
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
                      "Sign up",
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
                  text: "Sign up",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        await regester();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ChatPage().id,
                          (route) => false,arguments: email,
                        );
                        showsnackbar(context, massage: "regesterd");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "weak-password") {
                          showsnackbar(
                            context,
                            massage: "The password provided is too weak.",
                          );
                        } else if (e.code == "email-already-in-use") {
                          showsnackbar(
                            context,
                            massage:
                                "The account already exists for that email.",
                          );
                        }

                        showsnackbar(context, massage: e.code);
                      }
                      isloading = false;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(height:12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "you have account?",
                  style: TextStyle(color: Colors.white, fontSize: 18)
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        " login",
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
      ),
    );
  }

  void showsnackbar(BuildContext context, {required String massage}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(massage)));
  }

  Future<void> regester() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
