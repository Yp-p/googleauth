import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth{
  Future<UserCredential> signIn(String email, String password);
  Future<UserCredential> SignUp(String email, String password);
  Future<User> getCurrentUser();
  Future<void> signOut();
  Future<bool> currentSign();
}

class Auth implements BaseAuth{
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<UserCredential> SignUp(String email, String password) async{
    try{
      UserCredential userCredential= await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<User> getCurrentUser() async{
    User user = auth.currentUser;
    return user;
  }

  @override
  Future<UserCredential> signIn(String email, String password) async{
   try{
     UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   } on FirebaseAuthException catch(e){
     if (e.code == 'user-not-found') {
       print('No user found for that email.');
     } else if (e.code == 'wrong-password') {
       print('Wrong password provided for that user.');
     }
   }
  }

  @override
  Future<void> signOut() async{
    // TODO: implement signOut
    return await FirebaseAuth.instance.signOut();
  }

  @override
  Future<bool> currentSign() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

}

