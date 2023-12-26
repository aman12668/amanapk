import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current authenticated user
  User? get currentUser => _auth.currentUser;

  // Fetch the current user's username from Firestore
  Future<String?> getCurrentUsername() async {
    try {
      if (currentUser != null) {
        // Specify the collection and document ID based on your Firestore structure
        DocumentSnapshot userDocument =
            await _firestore.collection('user').doc(currentUser!.uid).get();

        // Check if the document exists and contains a "username" field
        if (userDocument.exists && userDocument.data() != null) {
          return userDocument['userName'];
        } else {
          return null; // User document not found or does not contain a username
        }
      } else {
        return null; // No authenticated user
      }
    } catch (e) {
      print('Error getting current username: $e');
      return null;
    }
  }
}
