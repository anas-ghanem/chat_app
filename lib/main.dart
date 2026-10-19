import 'package:chat_app/conset.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/regster.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scholar Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kbackground,
        colorScheme: ColorScheme.fromSeed(seedColor: kprimarykey),
        appBarTheme: const AppBarTheme(
          backgroundColor: kprimarykey,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: kprimarykey, width: 1.5),
          ),
        ),
      ),
      routes: {
        Login().id: (context) => Login(),
        Regster().id: (context) => Regster(),
        ChatPage().id: (context) => ChatPage(),
      },
      home: Login(),
    );
  }
}
