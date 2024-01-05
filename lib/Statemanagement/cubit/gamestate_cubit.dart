import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jamguh_triva/Models/QuestionsModel.dart';
import 'package:jamguh_triva/Models/question.dart';
import 'package:meta/meta.dart';

part 'gamestate_state.dart';

class GamestateCubit extends Cubit<GamestateState> {
  GamestateCubit() : super(GamestateInitial());
  List<questionitem> items = [];
  late List<questions> Questions = [];
  FirebaseFirestore connectionString = FirebaseFirestore.instance;
  int Questionindex = 0;
  int Lister = 1;
  int selectedradio = 0;
  int total_correct = 4;
  int totalpoints = 0;
  String gameDifficulty = "Easy";

  Future<List<questions>> getQuestions() async {
    QuerySnapshot<Map<dynamic, dynamic>> documentobject =
    await connectionString.collection("Questions").get();
    Questions = documentobject.docs
        .map((e) => questions.fromDocumentSnapshot(e))
        .toList();
    //print(Questions);
    List<dynamic>yes = [];
    Questions.add(questions(Imageurl: "Imageurl",
        Category: "Category",
        Level: " Level",
        Question: " Question",
        Answer: "Answer",
        Responses: yes));
    return documentobject.docs
        .map((e) => questions.fromDocumentSnapshot(e))
        .toList();
  }

  void setRadio(int value) {
    selectedradio = value;
    emit(GamestateRadioChanged());
  }
  void GeneratePoints() {
    switch (gameDifficulty) {
      case "Easy":
        totalpoints += (2 * total_correct);
        break;
      case "Intermediate":
        totalpoints += (3 * total_correct);
        break;
      case "Advanced":
        totalpoints += (5 * total_correct);
        break;
    }
  }
  void pageSkipper() {
    Questionindex += 1;
    if (Questionindex < Questions.length) {
      Lister += 1;

      emit(NextPage());
      emit(GamestateRefreshed());
    }
    if (Questionindex >= Questions.length - 1) {
      print("Game Over");
      GeneratePoints();
      SaveData();
      emit(GameOver());
    } else if (Questionindex == 0) {}
    else {

    }
  }
  Future<void> generateLeaderboardProfile() async {
    Map<String, dynamic> data = {
      'UID': FirebaseAuth.instance.currentUser!.uid,
      'Points': 0
    };
    FirebaseFirestore.instance
        .collection('Leaderboard')
        .add(data)
        .then((DocumentReference documentReference) =>
        print("Leaderboard profile has been generated - ${documentReference
            .id}"))
        .catchError((error) => print(error));
  }
  void SaveData()async{
    if(await LeaderboardProfileChecker()){
      generateLeaderboardProfile();
      updateLeaderboard();
    }else{
      updateLeaderboard();
    }
  }
  Future<bool> LeaderboardProfileChecker() async {
    bool tobereturned = false;
    QuerySnapshot<Map<String, dynamic>> user = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (user.docs.isEmpty) {
      tobereturned = true;
    }
    return tobereturned;
  }

  void updateLeaderboard() {
    FirebaseFirestore.instance
        .collection('Leaderboard')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (var document in value.docs) {
        int updated = document.data()['Points'] + totalpoints;
        Map<String, dynamic> data = {
          'UID': FirebaseAuth.instance.currentUser!.uid,
          'Points': updated
        };
        FirebaseFirestore.instance
            .collection('Leaderboard')
            .doc(document.id)
            .update(data)
            .then((value) {
          print('Updated Successfully');
        }).catchError((error) {
          print('Error while updating');
        });
      }
    });
  }
}