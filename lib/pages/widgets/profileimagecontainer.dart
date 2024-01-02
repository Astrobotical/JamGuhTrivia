import 'package:flutter/material.dart';
import 'package:jamguh_triva/Models/profileimageModel.dart';

class profileimagecontainerwidget extends StatelessWidget {
  const profileimagecontainerwidget({super.key, required this.Data});
  final profileimageModel Data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.4,
      margin: EdgeInsets.only(top:1.43),
      height: 170,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.only(top:12,left: 12,right: 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 4),
              child:
               Image.network('${Data.ImageLink}', height:120 ,colorBlendMode:BlendMode.clear ,),
            ),
            Text('${Data.Name}',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}
