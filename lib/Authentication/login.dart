import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jamguh_triva/pages/gamecontainer.dart';
import 'package:jamguh_triva/pages/leaderboards.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    final googlesignIn = GoogleSignIn();
    GoogleSignInAccount? CurrentGoogleUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home:Scaffold(
            body: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const Playerleaderboards()));
                    });
                  }
                  return Center(
                      child: Column(children: [
                    Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: ElevatedButton(
                            onPressed: () async {
                              final googleUser = await googlesignIn.signIn();
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
                            child: Text("Login"))),
                  ]));
                })));
  }
}
