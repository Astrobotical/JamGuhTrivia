import 'package:bloc/bloc.dart';
import 'package:jamguh_triva/Models/QuestionsModel.dart';
import 'package:jamguh_triva/Models/question.dart';
import 'package:meta/meta.dart';

part 'gamestate_state.dart';

class GamestateCubit extends Cubit<GamestateState> {
  GamestateCubit() : super(GamestateInitial());
  List<questionitem> items = [];
  int selectedradio = 0;

  void setRadio(int value) {
    selectedradio = value;
    emit(GamestateRadioChanged());
    //emit(GamestateRefreshed());
  }
}
