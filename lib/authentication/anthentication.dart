import 'package:firebase_auth/firebase_auth.dart';
abstract class BaseAuth{
  Future<String> SignIn(String email, String password);
  Future<String> SignUp(String email, String password);
  Future<void> signOut();
  Future<User> getCurrentUser();
}

class Auth extends BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> SignIn(String email, String password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }


  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String> SignUp(String email, String password) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return user.uid;
  }

  @override
  Future<User> getCurrentUser() async {
    User user = await _firebaseAuth.currentUser;
    return user;
  }
}