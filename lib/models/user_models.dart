import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;
  
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String,dynamic> userData  = Map();

  void singIn({@required String email, @required String pass, @required VoidCallback onSucces, @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

   _auth.signInWithEmailAndPassword(email: email, password: pass).then((user){
     firebaseUser = user;
     onSucces();
     isLoading = false;
     notifyListeners();
   }).catchError((e){
      onFail();   
     isLoading = false;
     notifyListeners();
   });

  }
  void singUp({@required Map<String, dynamic> userData,@required String pass,@required VoidCallback onSucess,@required VoidCallback onFail} ) {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(email: userData["email"], password: pass).then((user) async{
      firebaseUser = user;
      onSucess();
      isLoading = false;
      notifyListeners();

      await _saveUserData(userData);
    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();

    });
  }
  void singOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }
  void recoverPass() {

  }
  bool isLogged() {
    return firebaseUser != null;
    
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData)async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
  
}