import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jamguh_triva/Adhelper.dart';
import 'package:jamguh_triva/Authentication/login.dart';
import 'package:jamguh_triva/Models/QuestionsModel.dart';
import 'package:jamguh_triva/Statemanagement/cubit/gamestate_cubit.dart';
import 'package:jamguh_triva/pages/Gameover.dart';
import 'package:jamguh_triva/pages/gamelayout.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GameContainer extends StatefulWidget {
  const GameContainer({super.key});

  @override
  State<GameContainer> createState() => _GameContainerState();
}

class _GameContainerState extends State<GameContainer> {
  FirebaseFirestore connectionString = FirebaseFirestore.instance;
  late List<questions> SavedData = [];
  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  InterstitialAd? _interstitialAd;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              final methodobj = context.read<GamestateCubit>();
              methodobj.pushPage();
            },
          );
          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var methodObject = context.read<GamestateCubit>();
    return Material(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<GamestateCubit, GamestateState>(
                  builder: (context, state) {
                if (state is GameOver) {
                  if (methodObject.isuserSubscribed()) {
                  } else {
                    if (_interstitialAd != null) {
                      _interstitialAd?.show();
                    } else {
                      return GameOverPage();
                    }
                  }
                }
                if (state is Movepage) {
                  return GameOverPage();
                }
                if (state is NextPage) {
                  return SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: FutureBuilder<List<questions>>(
                          future: methodObject.getQuestions(),
                          builder: (context, snapped) {
                            return ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return gamelayout(
                                      Data: methodObject.Questions[
                                          methodObject.Questionindex]);
                                });
                          }));
                }
                return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: FutureBuilder<List<questions>>(
                        future: methodObject.getQuestions(),
                        builder: (context, snapped) {
                          return ListView.builder(
                              itemCount: 1,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return gamelayout(
                                    Data: methodObject
                                        .Questions[methodObject.Questionindex]);
                              });
                        }));
              })
            ]),
      )),
    );
  }
}
