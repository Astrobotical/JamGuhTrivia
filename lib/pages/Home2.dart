import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamguh_triva/Statemanagement/cubit/completesignup_cubit.dart';
import 'package:jamguh_triva/Statemanagement/cubit/cubit/difficulty_cubit.dart';
import 'package:jamguh_triva/Statemanagement/cubit/gamestate_cubit.dart';
import 'package:jamguh_triva/pages/widgets/completeusersignup.dart';


class MyHomePageTwo extends StatelessWidget {
  final DifficultyCubit difficultyCubit = DifficultyCubit();

  @override
  Widget build(BuildContext context) {
    final methodobj = context.read<GamestateCubit>();
    final startobj = context.read<CompletesignupCubit>();
    return Scaffold(body: BlocBuilder<CompletesignupCubit, CompletesignupState>(
        builder: (context, state) {
      if (state is CompletesignupRequest) {
        return const completeUserSignup();
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(88.0),
              child: Image(
                  image:
                      AssetImage("assets/images/jamaica_flag_brushStroke.png")),
            ),
            const Text(
              "Select Difficulty",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                List<Color> colorlist = [
                  Colors.black,
                  Colors.green,
                  Colors.yellow
                ];
                List<String> difficulty = [
                  "Beginner",
                  "Intermediate",
                  "Advanced"
                ];
                List<Difficulty> difficultyEvents = [
                  Difficulty.beginner,
                  Difficulty.intermediate,
                  Difficulty.advanced
                ];
                List<int> points = [2, 3, 5];

                return GestureDetector(
                  onTap: () {
                    switch(difficultyEvents[index]){
                      case Difficulty.beginner:
                        methodobj.setDifficulty('Beginner');
                        break;
                      case Difficulty.intermediate:
                        methodobj.setDifficulty('Intermediate');
                        break;
                      case Difficulty.advanced:
                        methodobj.setDifficulty('Advanced');
                        break;
                    }
                    startobj.StartGame();
                    //difficultyCubit.selectDifficulty(difficultyEvents[index]);
                  },
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 50,
                              width: 15,
                              decoration: BoxDecoration(
                                color: colorlist[index],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                difficulty[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 102, 102, 102),
                                    fontSize: 12,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: points[index]
                                          .toString(), // Bold and slightly larger
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            18, // Slightly larger than the rest
                                      ),
                                    ),
                                    const TextSpan(
                                        text: " points per correct answer"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }));
  }
}
