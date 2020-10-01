
import 'package:flutter/foundation.dart';

class LoginOutProvider extends ChangeNotifier{

   bool withoutLogIn=false;
  bool signOutBool=false;
getSign()=>signOutBool;
getWithoutLogIn()=>withoutLogIn;
void changeSign(){
  signOutBool= signOutBool==false?true:false;
  notifyListeners();
}

void changeWithoutLogIn(){
  withoutLogIn= withoutLogIn==false?true:false;
  notifyListeners();
}





}