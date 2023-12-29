import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jamguh_triva/Authentication/login.dart';
import 'package:jamguh_triva/Observer.dart';
import 'package:jamguh_triva/Statemanagement/cubit/gamestate_cubit.dart';
import 'package:jamguh_triva/Statemanagement/cubit/leaderboards_manager_cubit.dart';
import 'package:jamguh_triva/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamguh_triva/pages/gamecontainer.dart';

bool shouldUseFirestoreEmulator = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<GamestateCubit>(
        create: (context) => GamestateCubit(),
      ),
      BlocProvider<LeaderboardsManagerCubit>(
        create: (_)=>LeaderboardsManagerCubit()..getLeaderboard())
    ],
    child:login(),
    ),
  );
  Bloc.observer = CubitObserver();
  //  FirestoreExampleApp());
}