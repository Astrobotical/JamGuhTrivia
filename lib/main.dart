import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jamguh_triva/Authentication/login.dart';
import 'package:jamguh_triva/Observer.dart';
import 'package:jamguh_triva/Statemanagement/cubit/completesignup_cubit.dart';
import 'package:jamguh_triva/Statemanagement/cubit/gamestate_cubit.dart';
import 'package:jamguh_triva/Statemanagement/cubit/leaderboards_manager_cubit.dart';
import 'package:jamguh_triva/Statemanagement/cubit/profilestate_cubit.dart';
import 'package:jamguh_triva/Statemanagement/cubit/store_page_cubit.dart';
import 'package:jamguh_triva/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamguh_triva/pages/gamecontainer.dart';
import 'package:advertising_id/advertising_id.dart';
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
        create: (_)=>LeaderboardsManagerCubit()..getLeaderboard()),
      BlocProvider<ProfilestateCubit>(
        create: (_)=>ProfilestateCubit()..GetUserIcons()),
        BlocProvider<CompletesignupCubit>(
          create: (_)=>CompletesignupCubit(),
        ),
          BlocProvider<StorePageCubit>(
            create:(_)=> StorePageCubit()..getitems())
    ],
    child:login(),
    ),
  );
  Bloc.observer = CubitObserver();
  //  FirestoreExampleApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _advertisingId = '';
  bool? _isLimitAdTrackingEnabled;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String? advertisingId;
    bool? isLimitAdTrackingEnabled;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      advertisingId = await AdvertisingId.id(true);
    } on PlatformException {
      advertisingId = 'Failed to get platform version.';
    }

    try {
      isLimitAdTrackingEnabled = await AdvertisingId.isLimitAdTrackingEnabled;
    } on PlatformException {
      isLimitAdTrackingEnabled = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _advertisingId = advertisingId;
      _isLimitAdTrackingEnabled = isLimitAdTrackingEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Advertising Id: $_advertisingId'),
              Text('isLimitAdTrackingEnabled : $_isLimitAdTrackingEnabled'),
            ],
          ),
        ),
      ),
    );
  }
}