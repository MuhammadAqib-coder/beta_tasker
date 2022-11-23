import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CloudDataService {
  static final String authId = FirebaseAuth.instance.currentUser!.uid;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String> createUserData() async {
    String url = '';
    //var map= <String, dynamic>{};
    await _firestore.collection('users').doc(authId).get().then((value) async {
      if (value.exists) {
        //map = value.data()!;
        url = value.data()!['image_url'];
      } else {
        await _firestore.collection('users').doc(authId).set({
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
    await _firestore.collection('users').doc(authId).update({
      'full_name': fullname,
      'user_name': username,
      'date_of_birth': date,
      'email': email,
      'phone': phone,
      'role': role
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getIncompleteTaskStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authId)
        .collection('tasks')
        .where('is_completed', isEqualTo: false)
        .orderBy('priority', descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCompleteTaskStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authId)
        .collection('tasks')
        .where('is_completed', isEqualTo: true)
        .snapshots();
  }

  static updateRoundCheckBox(ValueNotifier<bool> isCheck, String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authId)
        .collection('tasks')
        .doc(id)
        .update({'is_completed': isCheck.value});
  }
  static updateProjectRoundCheckBox(ValueNotifier<bool> isCheck, String id,String proId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authId)
        .collection('projects')
        .doc(proId).collection('projectTasks').doc(id)
        .update({'is_completed': isCheck.value});
  }
}
