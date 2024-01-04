import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jamguh_triva/Statemanagement/cubit/completesignup_cubit.dart';
import 'package:jamguh_triva/pages/Home.dart';
import 'package:jamguh_triva/pages/Profileimagechooser.dart';
import 'package:jamguh_triva/pages/Storedpage.dart';
import 'package:jamguh_triva/pages/gamecontainer.dart';
import 'package:jamguh_triva/pages/leaderboards.dart';
import 'package:jamguh_triva/pages/signout.dart';
import 'package:jamguh_triva/pages/usernamecollector.dart';
import 'package:jamguh_triva/pages/widgets/completeusersignup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String title;
  int index = 0;
  int? coins;
  String? username;
  List<Map<String, dynamic>> menuItems = [
    {'title': 'Homepage', 'icon': Icons.home, 'place': 0},
    {'title': 'Leaderboard', 'icon': Icons.leaderboard, 'place': 1},
    {'title': 'Profile Settings', 'icon': Icons.settings, 'place': 2},
    {'title': 'Shop', 'icon': Icons.shopping_cart, 'place': 3},
    {'title': 'Logout', 'icon': Icons.exit_to_app, 'place': 4},
  ];
  List<Widget> currentView = [
    GameContainer(),
    Playerleaderboards(),
    profileimagechooser(),
    StorePage(),
    SignOutPage()
  ];
  @override
  void initState() {
    title = "Home";
    CheckUserRegistrationStatus();
    getUserdetails();
    super.initState();
  }

  void getUserdetails() async {
    FirebaseFirestore.instance
        .collection('UserProfiles')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((value) {
           for (var document in value.docs) {
        setState(() {
          username = document.data()['username'];
          coins = document.data()['jamcoins'];
        });
      }
    });
  }

  Future<void> CheckUserRegistrationStatus() async {
    int counter = 0;
    var bloccontext = context.read<CompletesignupCubit>();
    QuerySnapshot<Map<String, dynamic>> signeduser = await FirebaseFirestore
        .instance
        .collection('UserProfiles')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('username', isNotEqualTo: "")
        .get();
    if (signeduser.docs.isEmpty) {
      FirebaseFirestore.instance
          .collection('UserProfiles')
          .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          print("User doesnt have an account");
          if (counter == 0) {
            setState(() {
              ++counter;
            });
            bloccontext.generateProfile(FirebaseAuth.instance.currentUser!.uid);
          }
        } else {
          print("We moving to the other page");
        }
      });
      bloccontext.loadWidget();
      print("User has an account but doesnt have a username");
    } else {
      print("User has an account");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey,
              elevation: 0,
              title: Text("JamGuh Trivia"),
              actions: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Icon(Icons.attach_money_outlined, size: 18,color: Colors.white,)),
                        TextSpan(
                            text: "${coins ?? 0}",
                            style: TextStyle(fontSize: 18))
                      ],
                    ))),
                Gap(15)
              ],
              centerTitle: true,
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Welcome \n${username ?? 'Default Name'}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  for (var item in menuItems)
                    ListTile(
                      title: Text(item['title']),
                      leading: Icon(item['icon']),
                      onTap: () {
                        setState(() {
                          index = item['place'];
                        });

                        Navigator.pop(context); // Close the drawer
                        // Add navigation logic here based on the tapped item
                      },
                    ),
                ],
              ),
            ),
            body: BlocBuilder<CompletesignupCubit, CompletesignupState>(
                builder: (BuildContext context, CompletesignupState state) {
              if (state is CompletesignupRequest) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const usernameCollector()));
                });
              }
              if(state is GameDoneLeaderboardRedirect){
                return Playerleaderboards();
              }
              return currentView[index];
            })));
  }

  void prompt(BuildContext context) async {
    var controller = context.read<CompletesignupCubit>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Create a Username'),
            content: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 16),
              child: TextFormField(
                controller: controller.username,
                textCapitalization: TextCapitalization.sentences,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE0E3E7),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4B39EF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Color(0xCCFFFFFF),
                ),
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF101213),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }
}
/*
class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? Username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void GetUserIcons() async {
    QuerySnapshot<Map<String, dynamic>> signeduser = await FirebaseFirestore
        .instance
        .collection('UserProfiles')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Welcome \n${FirebaseAuth.instance.currentUser!.displayName}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          for (var item in menuItems)
            ListTile(
              title: Text(item['title']),
              leading: Icon(item['icon']),
              onTap: () {
                // Handle item tap
                Navigator.pop(context); // Close the drawer
                // Add navigation logic here based on the tapped item
              },
            ),
        ],
      ),
    );
  }
}
*/
