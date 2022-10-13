import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudDataService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String> createUserData() async {
    String url = '';
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        url = value.data()!['image_url'];
      } else {
        await _firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'image_url': '',
          'full_name': '',
          'user_name': '',
          'date_of_birth': '',
          'email': '',
          'phone': '',
          'role': ''
        });
      }
    });
    return url;
  }

  static insertData(fullname, username, date, email, phone, role) async {
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'full_name': fullname,
      'user_name': username,
      'date_of_birth': date,
      'email': email,
      'phone': phone,
      'role': role
    });
  }
}
