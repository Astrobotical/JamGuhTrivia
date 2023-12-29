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
  Future<List<Leaderboardmodel>> getLeaderboard() async {
    List<int> storedpoints = [];
    QuerySnapshot<Map<dynamic, dynamic>> Icons =
        await connectionString.collection("icons").get();
    QuerySnapshot<Map<dynamic, dynamic>> profile =
        await connectionString.collection("UserProfiles").get();
    await connectionString.collection("Leaderboard").get().then((value) {
      for (var docSnapshot in value.docs) {
        for (var profileSnapshot in profile.docs) {
          if (profileSnapshot.data()['UID'] == docSnapshot.data()['UID']) {
            Leaderboardmodel User = Leaderboardmodel(
                currentPosition: 1,
                profileImage: profileSnapshot.data()['profileImage'],
                points: docSnapshot.data()['Points'],
                username: profileSnapshot.data()['username']);
            topthree.add(User);
            storedpoints.add(docSnapshot.data()['Points']);
          }
        }
      }

      int LargestPoints = 0;
      storedpoints.sort((b, a) => a.compareTo(b));
      int count = 0;
      for (Leaderboardmodel storeduser in topthree) {
        if (storeduser.points == storedpoints[count]) {
          if (count == 0) {
            storeduser.currentPosition = 1;
            LargestPoints = storedpoints[count];
            count++;
          } else {
            if (storedpoints[count] <= LargestPoints &&
                storedpoints[count] > LargestPoints) {
              LargestPoints = storedpoints[count];
              storeduser.currentPosition = count;
              count++;
            }
          }
        }
        rebuilt.add(storeduser);
      }
    });

    //print(rebuilt);
    updatestate();
    return rebuilt;
  }

  void updatestate() {
    print(rebuilt);
    emit(LeaderbaordsManagerDone());

  }

  void getleaderboard() async {
    List<int> storedpoints = [];
    QuerySnapshot<Map<dynamic, dynamic>> Icons =
        await connectionString.collection("icons").get();
    QuerySnapshot<Map<dynamic, dynamic>> profile =
        await connectionString.collection("UserProfiles").get();
    await connectionString.collection("Leaderboard").get().then((value) {
      for (var docSnapshot in value.docs) {
        for (var profileSnapshot in profile.docs) {
          if (profileSnapshot.data()['UID'] == docSnapshot.data()['UID']) {
            Leaderboardmodel User = Leaderboardmodel(
                currentPosition: 1,
                profileImage: profileSnapshot.data()['profileImage'],
                points: docSnapshot.data()['Points'],
                username: profileSnapshot.data()['username']);
            topthree.add(User);
            storedpoints.add(docSnapshot.data()['Points']);
          }
        }
      }

      int LargestPoints = 0;
      storedpoints.sort((b, a) => a.compareTo(b));
      int count = 0;
      for (Leaderboardmodel storeduser in topthree) {
        if (storeduser.points == storedpoints[count]) {
          if (count == 0) {
            storeduser.currentPosition = 1;
            LargestPoints = storedpoints[count];
            count++;
          } else {
            if (storedpoints[count] <= LargestPoints &&
                storedpoints[count] > LargestPoints) {
              LargestPoints = storedpoints[count];
              storeduser.currentPosition = count;
              count++;
            }
          }
        }
        rebuilt.add(storeduser);
      }
    });
    print(rebuilt);
  }
}
