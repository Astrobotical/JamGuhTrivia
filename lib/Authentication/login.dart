// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:jamguh_triva/pages/Homepage.dart';
import 'package:jamguh_triva/pages/Profileimagechooser.dart';
import 'package:jamguh_triva/pages/gamecontainer.dart';
import 'package:jamguh_triva/pages/leaderboards.dart';

class login extends StatelessWidget {
  login({super.key});

  var status = Permission.storage.request();
  
  @override
  Widget build(BuildContext context) {
    final googlesignIn = GoogleSignIn();
    GoogleSignInAccount? CurrentGoogleUser;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
            backgroundColor: Colors.green,
            body: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    });
                  }
                  return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        const Image(
                            image: AssetImage(
                                "lib/assets/images/jamaica_flag_brushStroke.png")),
                        const Text(
                          "Welcome to Jamguh Trivia",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const Gap(30),
                        Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.yellow),
                                ),
                                onPressed: () async {
                                  final googleUser =
                                      await googlesignIn.signIn();
                                  if (googleUser == null) return;
                                  CurrentGoogleUser = googleUser;
                                  final googleAuth =
                                      await googleUser.authentication;
                                  final creds = GoogleAuthProvider.credential(
                                    accessToken: googleAuth.accessToken,
                                    idToken: googleAuth.idToken,
                                  );
                                  await FirebaseAuth.instance
                                      .signInWithCredential(creds);
                                },
                                child: Text(
                                  "Play",
                                  style: TextStyle(color: Colors.black),
                                ))),
                      ]));
                })));
  }
}
