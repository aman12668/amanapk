import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ENEB_HUB/video_player/controllers/auth_controller.dart';
import 'package:ENEB_HUB/video_player/views/Screens/add_video_screen.dart';
import 'package:ENEB_HUB/video_player/views/Screens/profile_screen.dart';
import 'package:ENEB_HUB/video_player/views/Screens/search_screen.dart';
import 'package:ENEB_HUB/video_player/views/Screens/video_screen.dart';

List pages = [
  VideoScreen(),
  
  const AddVideoScreen(),
  Text('Messages Screen'),
  ProfileScreen(uid: authController.user.uid),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;
