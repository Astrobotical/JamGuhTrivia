import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamguh_triva/Statemanagement/cubit/gamestate_cubit.dart';

class QuestionRadio extends StatefulWidget {
  final String text;
  final int index;
  final int selectedButton;
  final Function press;

  const QuestionRadio({
    Key? key,
    required this.text,
    required this.index,
    required this.selectedButton,
    required this.press,
  }) : super();

  @override
  QuestionRadioPage createState() => QuestionRadioPage();
}

class QuestionRadioPage extends State<QuestionRadio> {
  int id = 1;
  late bool _isButtonDisabled;
  QuestionRadioPage();

  @override
  void initState() {
    _isButtonDisabled = false;
  }

  late int _selected;

  @override
  Widget build(BuildContext context) {
    final currentstate = context.read<GamestateCubit>();
    return InkWell(
      onTap: () {
        widget.press(widget.index);
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  // height: 60.0,
                  child: Theme(
                data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.grey,
                    disabledColor: Colors.blue),
                child: Column(children: [
                  RadioListTile(
                    title: Text(
                      "${widget.text}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      softWrap: true,
                    ),
                    /*Here the selectedButton which is null initially takes place of value after onChanged. Now, I need to clear the selected button when other button is clicked */
                    groupValue: widget.selectedButton,
                    value: widget.index,
                    activeColor: Colors.green,
                    onChanged: (val) async {
                      widget.press(widget.index);
                    },
                    toggleable: true,
                  ),
                ]),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
