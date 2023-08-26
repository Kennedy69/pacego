import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserProvider with ChangeNotifier {

  String username = "";
  // function that gets username

  String get getUsername => username;

  // function to set username

  void setusername(String name){
    username = name;
    
    notifyListeners();
  }

  // void setUsername(String? displayName) {}

  // age values
  int age = 0;

  // get age
  
  int get getAge => age;

  void setAge(int value) {
    age = value;
    notifyListeners();
  }

  // email values

  String email = "";

  // get email

  String get getEmail => email;

  // set email
  
  void setEmail(String input) {
    email = input;
    notifyListeners();
  }



}
