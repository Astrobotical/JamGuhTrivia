import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jamguh_triva/Authentication/login.dart';
import 'package:jamguh_triva/Models/QuestionsModel.dart';
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
  }

  Future<List<questions>> getQuestions() async {
    QuerySnapshot<Map<dynamic, dynamic>> documentobject =
        await connectionString.collection("Questions").get();
    setState(() {
      SavedData = documentobject.docs
          .map((e) => questions.fromDocumentSnapshot(e))
          .toList();
    });
   // print(SavedData);
    return documentobject.docs
        .map((e) => questions.fromDocumentSnapshot(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              width: MediaQuery.sizeOf(context).width,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Column(children: [
                  ElevatedButton(onPressed: () async{
                    FirebaseAuth.instance.signOut();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>login()));
                    });
                  }
                      , child: Text("logout"))
                ]),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          child: FutureBuilder<List<questions>>(
                              future: getQuestions(),
                              builder: (context, snapped) {
                                return ListView.builder(
                                    itemCount: SavedData.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return gamelayout(Data: SavedData[index]);
                                    });
                              })))
                ]),
          )),
    );
  }
}
