import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jamguh_triva/Models/leaderboardModel.dart';
import 'package:jamguh_triva/pages/widgets/top3.dart';
import 'package:meta/meta.dart';

part 'leaderboards_manager_state.dart';

class LeaderboardsManagerCubit extends Cubit<LeaderboardsManagerState> {
  LeaderboardsManagerCubit() : super(LeaderboardsManagerInitial());
  List<Leaderboardmodel> topthree = [];
  FirebaseFirestore connectionString = FirebaseFirestore.instance;
  List<Leaderboardmodel> rebuilt = [];
  int count = 1;

  Future<List<Leaderboardmodel>> getLeaderboard() async {
    List<int> storedpoints = [];
    int position = 0;
    QuerySnapshot<Map<dynamic, dynamic>> profile =
    await connectionString.collection("UserProfiles").get();
    await connectionString.collection("Leaderboard")
        .orderBy('Points', descending: true)
        .get().then((value) {
      for (var docSnapshot in value.docs) {
        for (var profileSnapshot in profile.docs) {
          if (profileSnapshot.data()['UID'] == docSnapshot.data()['UID']) {
            Leaderboardmodel User = Leaderboardmodel(
              currentPosition: ++position,
              profileImage: profileSnapshot.data()['profileImage'],
              points: docSnapshot.data()['Points'],
              username: profileSnapshot.data()['username'],
              isSubscribed: profileSnapshot.data()['issubscribed'],
            );
            topthree.add(User);
            storedpoints.add(docSnapshot.data()['Points']);
          }
        }
      }
    });
    rebuilt = topthree;
    updatestate();
    return rebuilt;
  }

  void counting() {
    count + 1;
  }

  void updatestate() {
    emit(LeaderbaordsManagerDone());
  }

  void resetstate() {
    rebuilt.clear();
    topthree.clear();
    getLeaderboard();
    print(rebuilt);
    emit(LeaderbaordsManagerRefresh());
    emit(LeaderbaordsManagerDone());
  }
}