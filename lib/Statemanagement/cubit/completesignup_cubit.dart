import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
part 'completesignup_state.dart';

class CompletesignupCubit extends Cubit<CompletesignupState> {
  CompletesignupCubit() : super(CompletesignupInitial());
  TextEditingController username = TextEditingController();
  FirebaseFirestore connectionString = FirebaseFirestore.instance;

  void loadWidget() {
    emit(CompletesignupRequest());
  }

  Future<void> generateProfile(String userid) async {
    Map<String, dynamic> data = {
      'UID': userid,
      'icons': ['hVAOPXqfgvndhSMn5Q4E'],
      'issubscribed': false,
      'jamcoins': 0,
      'profileImage':
          'https://firebasestorage.googleapis.com/v0/b/jamguhtrivia.appspot.com/o/defaulticon.jpeg?alt=media&token=e1b68ded-7994-4c97-84d5-3927e970f00e',
      'selectedicon': 'hVAOPXqfgvndhSMn5Q4E',
      'username': ''
    };
    FirebaseFirestore.instance
        .collection('UserProfiles')
        .add(data)
        .then((DocumentReference documentReference) =>
            print("Document has been generated - ${documentReference.id}"))
        .catchError((error) => print(error));
  }

  Future<void> saveUser() async {
    Map<Object, Object?> data = {'username': username.text};
    if (await usernamechecker(username.text)) {
      FirebaseFirestore.instance
          .collection('UserProfiles')
          .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        for (var document in value.docs) {
          FirebaseFirestore.instance
              .collection('UserProfiles')
              .doc(document.id)
              .update(data)
              .then((value) {
            print('Updated Successfully');
            emit(CompletesignupSuccess());
          }).catchError((error) {
            print('Error while updating');
            emit(CompletesignupError());
          });
        }
      });
    }
  }

  Future<bool> usernamechecker(String username) async {
    bool tobereturned = false;
    QuerySnapshot<Map<String, dynamic>> user = await FirebaseFirestore.instance
        .collection('UserProfiles')
        .where('username', isEqualTo: username)
        .get();
    if (user.docs.isEmpty) {
      tobereturned = true;
    }
    return tobereturned;
  }
}
