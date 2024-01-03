import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jamguh_triva/Models/profileimageModel.dart';
import 'package:meta/meta.dart';

part 'profilestate_state.dart';

class ProfilestateCubit extends Cubit<ProfilestateState> {
  ProfilestateCubit() : super(ProfilestateInitial());
  FirebaseFirestore connectionString = FirebaseFirestore.instance;
  List<String?> iconID = [];
  List<profileimageModel> Profiles = [];

  bool? isSubscribed;
  int counter = 0;
  Future<QuerySnapshot<Map<String, dynamic>>> Icons =
      FirebaseFirestore.instance.collection("icons").get();
  late String ProfileImage = "";
  void Increment() {
    counter += 1;
  }

  Stream<QuerySnapshot> userIcons = FirebaseFirestore.instance
      .collection('UserProfiles')
      .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  void GetUserIcons() async {
    Profiles.clear();
    Profiles = [];
    QuerySnapshot<Map<String, dynamic>> signeduser = await connectionString
        .collection('UserProfiles')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    QuerySnapshot<Map<dynamic, dynamic>> Icons =
        await connectionString.collection("icons").get();
    for (var user in signeduser.docs) {
      isSubscribed = user.data()['issubscribed'];
      ProfileImage = user.data()['profileImage'];
      for (var ID in user.data()['icons']) {
        iconID.add(ID);
      }
    }
    for (var icons in Icons.docs) {
      for (int counter = 0; counter < iconID.length; counter++) {
        if (iconID[counter] == icons.id) {
          profileimageModel icon = profileimageModel(
              UID: icons.data()['UID'],
              Name: icons.data()['Name'],
              ImageLink: icons.data()['ImageURL']);

          Profiles.add(icon);
        }
      }
    }
    emit(ProfilestateDone());
    emit(ProfilestateRefresh());
    emit(ProfilestateDone());
  }

  void Reset() {
    Profiles.clear();
    Profiles = [];
    //  GetUserIcons();
  }

  void setProfileimage(String UID) async {
    FirebaseFirestore.instance
        .collection('icons')
        .where('UID', isEqualTo: UID)
        .get()
        .then((value) {
      for (var documenticon in value.docs) {
        ProfileImage = documenticon.data()['ImageURL'];
        Map<Object, Object?> data = {'profileImage': ProfileImage};
        FirebaseFirestore.instance
            .collection('UserProfiles')
            .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
          for (var currentdocument in value.docs) {
            FirebaseFirestore.instance
                .collection('UserProfiles')
                .doc(currentdocument.id)
                .update(data)
                .then((value) {
              print('Icon Updated Successfully');
            });
            emit(ProfilestateDone());
          }
        });
      }
    });
  }
}
