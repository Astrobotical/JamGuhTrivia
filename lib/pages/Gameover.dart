import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jamguh_triva/Statemanagement/cubit/completesignup_cubit.dart';
import 'package:jamguh_triva/Statemanagement/cubit/gamestate_cubit.dart';

class GameOverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var methodobject = context.read<GamestateCubit>();
    var main = context.read<CompletesignupCubit>();
    return  Center(child:
    Container(
      margin: EdgeInsets.only(top:50),

    child:
    Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Points Earned: ${methodobject.totalpoints}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Game Difficulty: ${methodobject.gameDifficulty}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                main.redirectaftergame();
              },
              child: Text('Go to Main Menu'),
            ),
          ],
    ))
        );
  }
}