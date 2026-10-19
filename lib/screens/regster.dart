import 'package:chat_app/conset.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/widgets.dart/button.dart';
import 'package:chat_app/widgets.dart/testfild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Regster extends StatefulWidget {
  Regster({super.key});
  final String id = 'regster_page';

  @override
  State<Regster> createState() => _RegsterState();
}

class _RegsterState extends State<Regster> {
  String email = '';
  String password = '';
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isloading = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kbackground,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: ksoftBlue,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Image.asset('assets/images/scholar.png'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Center(
                          child: Text(
                            'Scholar Chat',
                            style: TextStyle(
                              fontSize: 28,
                              color: kprimarykey,
                              fontFamily: 'Pacifico',
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            fontSize: 28,
                            color: kprimarykey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'أنشئ حسابك الآن وابدأ بمشاركة الرسائل.',
                          style: TextStyle(
                            color: Color(0xff667085),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 22),
                        custom_textfild(
                          hinttext: 'البريد الإلكتروني',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'الرجاء إدخال البريد الإلكتروني';
                            }
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value!.trim())) {
                              return 'صيغة البريد الإلكتروني غير صحيحة';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value.trim();
                          },
                        ),
                        const SizedBox(height: 16),
                        custom_textfild(
                          hinttext: 'كلمة المرور',
                          prefixIcon: Icons.lock_outline,
                          obscureText: !isPasswordVisible,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: kprimarykey,
                            ),
                          ),
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'الرجاء إدخال كلمة المرور';
                            }
                            if ((value ?? '').length < 6) {
                              return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        const SizedBox(height: 18),
                        custom_button(
                          text: 'إنشاء الحساب',
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              isloading = true;
                              setState(() {});
                              try {
                                await regester();
                                if (!mounted) return;
                                showsnackbar(
                                  context,
                                  massage: 'تم إنشاء الحساب بنجاح',
                                );
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  ChatPage().id,
                                  (route) => false,
                                  arguments: email,
                                );
                              } on FirebaseAuthException catch (e) {
                                if (!mounted) return;
                                if (e.code == 'weak-password') {
                                  showsnackbar(
                                    context,
                                    massage:
                                        'كلمة المرور ضعيفة جدًا، جرّب كلمة أقوى.',
                                  );
                                } else if (e.code == 'email-already-in-use') {
                                  showsnackbar(
                                    context,
                                    massage: 'هذا البريد مستخدم بالفعل.',
                                  );
                                } else {
                                  showsnackbar(
                                    context,
                                    massage: e.message ?? 'حدث خطأ ما',
                                  );
                                }
                              } finally {
                                if (mounted) {
                                  isloading = false;
                                  setState(() {});
                                }
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'لديك حساب؟',
                              style: TextStyle(
                                color: Color(0xff475467),
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  color: kprimarykey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showsnackbar(BuildContext context, {required String massage}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(massage),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> regester() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
