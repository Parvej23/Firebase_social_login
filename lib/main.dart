import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_login/auth/phone_auth.dart';
import 'package:social_login/auth/reset_password.dart';
import 'package:social_login/auth/sign_in.dart';
import 'package:social_login/auth/sign_up.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: SignIn()
      //home: PhoneAuths()
    );
  }
}
