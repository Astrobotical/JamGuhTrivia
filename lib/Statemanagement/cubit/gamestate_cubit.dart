import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<questions>> getQuestions() async {
    QuerySnapshot<Map<dynamic, dynamic>> documentobject =
    await connectionString.collection("Questions").get();
    Questions = documentobject.docs
          .map((e) => questions.fromDocumentSnapshot(e))
          .toList();
    print(Questions);
    return documentobject.docs
        .map((e) => questions.fromDocumentSnapshot(e))
        .toList();
  }
  void setRadio(int value) {
    selectedradio = value;
    emit(GamestateRadioChanged());
  }
  void pageSkipper(){
    if(Questionindex ==  0 )
      {
      }else{
      Lister+=1;
    }
    Questionindex += 1;
    emit(NextPage());
    emit(GamestateRefreshed());
  }
}
