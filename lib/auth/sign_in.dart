import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login/auth/phone_auth.dart';
import 'package:social_login/auth/reset_password.dart';
import 'package:social_login/auth/sign_up.dart';
import 'package:social_login/welcome.dart';
class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  signIn(email, pass, context) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass,
      );
      if(credential.user!.uid.isNotEmpty){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  signInWithGoogle(context) async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential=
          await FirebaseAuth.instance.signInWithCredential(credential);
      var user= userCredential.user;
      if(user!.uid.isNotEmpty){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            WelcomePage()
        ));
      }
    }catch(e){
      print(e);
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 25,
              right: 25
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome', style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                )),
                Text('Login to your account', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                )),
                SizedBox(height: 50,),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
                SizedBox(height: 8,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text.rich(
                    TextSpan(
                      text: 'Forgot your password? ',children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=(){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_)=>ResetPassword()));
                          },
                          text: 'Reset Now',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent
                          ),
                        ),
                    ]
                    ),
                  ),
                ),
                Divider(color: Colors.transparent),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: (){
                      signIn(_emailController.text,
                          _passwordController.text, context);
                    },
                    child: Text('Sign In'),
                  ),
                ),
                Divider(color: Colors.transparent,),
                Text.rich(
                  TextSpan(text: 'Don\'t have an account? ', children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>
                        Navigator.push(context,
                          MaterialPageRoute(builder:(_)=>SignUp())
                        ),
                      text: 'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue
                      )
                    )
                  ]),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: (){
                          signInWithGoogle(context);
                        },
                        icon: Image.asset('assets/icons/search.png'),
                      ),
                      VerticalDivider(),
                      IconButton(
                        onPressed: ()=>Navigator.push(context,
                          MaterialPageRoute(builder: (_)=>PhoneAuths())
                        ),
                        icon: Icon(
                          Icons.call_outlined,
                          size: 32,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
