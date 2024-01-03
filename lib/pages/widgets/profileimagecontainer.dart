import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamguh_triva/Models/profileimageModel.dart';
import 'package:jamguh_triva/Statemanagement/cubit/leaderboards_manager_cubit.dart';
import 'package:jamguh_triva/Statemanagement/cubit/profilestate_cubit.dart';

class profileimagecontainerwidget extends StatefulWidget {
  const profileimagecontainerwidget({super.key, required this.Data});
  final profileimageModel Data;

  @override
  State<profileimagecontainerwidget> createState() =>
      _profileimagecontainerwidgetState();
}

class _profileimagecontainerwidgetState
    extends State<profileimagecontainerwidget> {
  @override
  Widget build(BuildContext context) {
    Color? currentColors = Colors.grey[300];
    final methodobject = context.read<ProfilestateCubit>();
    final methodleaderboardsobject = context.read<LeaderboardsManagerCubit>();
    return GestureDetector(
        onTapDown: (TapDownDetails) {
          methodobject.setProfileimage(widget.Data.UID);
          methodleaderboardsobject.resetstate();
          setState(() {
            print('This was clicked down');
            currentColors = Colors.blueAccent[800];
          });
        },
        onTapUp: (TapUpDetails) {
          setState(() {
            print('This was released');
            currentColors = Colors.grey[300];
          });
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.4,
          margin: EdgeInsets.only(top: 1.43),
          height: 170,
          decoration: BoxDecoration(
            color: currentColors,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 4),
                  child: Image.network(
                    '${widget.Data.ImageLink}',
                    height: 120,
                    colorBlendMode: BlendMode.clear,
                  ),
                ),
                Text('${widget.Data.Name}',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 18))
              ],
            ),
          ),
        ));
  }
}
