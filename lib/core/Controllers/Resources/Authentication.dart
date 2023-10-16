import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty || username.isNotEmpty || password.isNotEmpty) {

        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then(
          (value) {
            _firestore.collection("user").doc(_auth.currentUser!.uid).set(
              {
                "email": email,
                "username": username,
                "password": password,
                "uid": _auth.currentUser!.uid,
              },
            );
          },
        );

        //
        log("User Uploaded");
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
