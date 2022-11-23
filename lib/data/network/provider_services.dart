import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProviderServices extends ChangeNotifier {
  //Query<Map> completeList = {} as Query<Map>;
  //List inCompleteList = [];
  int _complete = 0;
  int _incomplete = 0;
  double _percentage = 0.0;

  get complete => _complete;
  get inComplete => _incomplete;
  get percentage => _percentage;

  Future<void> updateCompleteList( String proId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('projects')
        .doc(proId)
        .collection('projectTasks')
        .where('is_completed', isEqualTo: true)
        .get()
        .then((value) => _complete = value.docs.length);

    notifyListeners();
  }

  updateInCompleteList( String proId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('projects')
        .doc(proId)
        .collection('projectTasks')
        .where('is_completed', isEqualTo: false)
        .get()
        .then((value) => _incomplete = value.docs.length);
    notifyListeners();
  }

  void calculatePercentage() {
    _percentage = double.parse(
            (_complete / (_complete + _incomplete)).toStringAsFixed(3)) *
        100;

    notifyListeners();
  }
}
