import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  Future<void> saveUserData(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      print("Error saving user data: $e");
    }
  }
    Future<User?> signUpWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      // Store additional user information in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'username': username,
        'email': email,
  
      });

      return user;
    } catch (e) {
      rethrow; // Propagate the error
    }
  }


Future<String> loginUserWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Safely get the user's email or handle null
    String? userEmail = userCredential.user?.email;
    
    if (userEmail != null) {
      // Handle success with the user's email
      return "success";
    } else {
      return "Email not found";
    }
  } catch (e) {
    return e.toString();
  }
}

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Error in signOut: $e");
    }
  }
}
