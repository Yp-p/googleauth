
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';



const Color gColor=Color(0xFF81C784);

Future<UserCredential> signInWithGoogle() async {

  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  print('hhh');

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}


Future<String> signUpWithEmail(String email, String password,) async {
  String error;
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      error=e.code;
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      error=e.code;
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e.toString());
  }


  return error;

}

Future<void> signout() async{
  return await FirebaseAuth.instance.signOut();
}

Future<String> loginwithEmail(String email, String password) async{
  String error;
  try{
    UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

  } on FirebaseAuthException catch(e){
    if (e.code == 'user-not-found') {
      error=e.code;
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      error=e.code;
      print('Wrong password provided for that user.');
    }
    error=e.code;
  }
  return error;


}







