import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  signOut(context) async{
    try{
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.logout),)
        ],
      ),
      body: Center(
        child: Text('Welcome',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w600,
            fontSize: 38,
          ),
        ),
      ),
    );
  }
}
