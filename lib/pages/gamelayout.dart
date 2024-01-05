import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:jamguh_triva/Models/QuestionsModel.dart';
import 'package:jamguh_triva/Statemanagement/cubit/gamestate_cubit.dart';
import 'package:jamguh_triva/pages/widgets/questionbuttons.dart';

class gamelayout extends StatefulWidget {
  const gamelayout({super.key, required this.Data});
  final questions Data;

  @override
  State<gamelayout> createState() => _gamelayoutState();
}

class _gamelayoutState extends State<gamelayout> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final statefulcontext = context.read<GamestateCubit>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(25),
          child: Image.network(
            widget.Data.Imageurl,
            width: MediaQuery.sizeOf(context).width,
            height:200,
          ),
        ),
        Gap(30),
        FittedBox(
          fit: BoxFit.fitWidth,
        child:
        Text(
          widget.Data.Question,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
    ),
        BlocBuilder<GamestateCubit, GamestateState>(builder: (context, state) {
          if (state is GamestateRadioChanged) {
            return SizedBox(
                height: 350,
                child: ListView.builder(
                    itemCount: widget.Data.Responses.length,
                    itemBuilder: (context, index) {
                      return QuestionRadio(
                          text: widget.Data.Responses[index],
                          index: index,
                          selectedButton: statefulcontext.selectedradio,
                          press: (selectedvalue) {
                            debugPrint('Radio button changed is here $selectedvalue');
                            statefulcontext.setRadio(selectedvalue);
                          });
                    }));
          }
          return SizedBox(
              height: 350,
              child: ListView.builder(
                  itemCount: widget.Data.Responses.length,
                  itemBuilder: (context, index) {
                    return QuestionRadio(
                        text: widget.Data.Responses[index],
                        index: index,
                        selectedButton: statefulcontext.selectedradio,
                        press: (selectedvalue)async {
                          debugPrint('Radio button is here $selectedvalue');
                          statefulcontext.setRadio(selectedvalue);
                        });
                  }));
        }),
        Container(
    width: double.infinity,
    child:
        Stack(
    children:[
      Align(
        alignment: Alignment.bottomCenter,
        child:Text('${statefulcontext.Lister}/${statefulcontext.Questions.length-1}',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),)
      ),
        Align(
          alignment: Alignment.bottomRight,
          child:
          InkWell(
            onTap: (){
              statefulcontext.pageSkipper();
            },
            child:
          Icon(
            Icons.arrow_circle_right_outlined,
            size: 80,
            weight: 16,
          ),
        )
        )
        ]
    ),
        ),
    ]);
  }

  _showToast(int index) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("${index} was clicked"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }
}
