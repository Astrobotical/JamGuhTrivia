import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:jamguh_triva/Models/leaderboardModel.dart';
import 'package:profile_photo/profile_photo.dart';

class Topthree extends StatefulWidget {
  const Topthree({super.key, required this.data});
  final Leaderboardmodel data;

  @override
  State<Topthree> createState() => _TopthreeState();
}

class _TopthreeState extends State<Topthree> {
  late Color persontheme;
  @override
  void initState() {
    themeChooser();
    super.initState();
  }

  void themeChooser() {
    setState(() {
      switch (widget.data.currentPosition) {
        case 1:
          persontheme = Colors.amber[900]!;
          break;
        case 2:
          persontheme = Colors.purple[300]!;
          break;
        case 3:
          persontheme = Colors.blueGrey[400]!;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${widget.data.currentPosition}',
              style: TextStyle(
                  color: persontheme,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          const Gap(10),
          Container(
            padding: EdgeInsets.all(5),
            width: 200,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: persontheme
              ),
              borderRadius: BorderRadius.circular(25)
            ),
        child: 
         Image.network(widget.data.profileImage,
         fit: BoxFit.cover
        ),
        ),
          Gap(20),
          Row(children: [
            Icon(
             Icons.pix_rounded
            ),
            Gap(20),
            Text('${widget.data.points}',style: TextStyle(color: persontheme),)
          ],
          ),
        ],
      ),
    );
  }
}
