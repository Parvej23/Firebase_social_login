import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_login/auth/sign_in.dart';

class ResetPassword extends StatelessWidget {

  TextEditingController _emailController = TextEditingController();
  resetPassword(email,context) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));

    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            left: 25,
            right: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot your password?',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'enter your email and reset password.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'email address',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: (){
                    resetPassword(_emailController.text,context);
                  },
                  child: Text('Reset Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}