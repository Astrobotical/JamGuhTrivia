import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jamguh_triva/Statemanagement/cubit/profilestate_cubit.dart';
import 'package:jamguh_triva/pages/widgets/profileimagecontainer.dart';

class profileimagechooser extends StatelessWidget {
  const profileimagechooser({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(child:
     Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        title: Text("Account Icons",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 30),),
        elevation: 0,
        backgroundColor: Colors.blueGrey[600],
        leading: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 25),
                onPressed: () => Navigator.of(context).pop(),
              ),
      ),
      body:
        BlocBuilder<ProfilestateCubit, ProfilestateState>(
            builder: (context, state) {
      final methodobj = context.read<ProfilestateCubit>();
      if(state is ProfilestateDone)
      {
        return Align(
          alignment: AlignmentDirectional(0, 0),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(30),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: 
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child:
                        Text('${methodobj.isSubscribed != null? "Subscribed": "Free"}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white)),
                      ),
                      ),
                      Text('Status',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                '${methodobj.ProfileImage != null ? methodobj.ProfileImage : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVg_IiPrWq4ijVMk-CA_MovxsvbsOdR8Qwkw&usqp=CAU"}',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: Text('${methodobj.iconID.length}',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white)),
                      ),
                      Text(
                        'Icons',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(0, -1),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child:
                              Text(
                                'My Profile Icons',
                                style: TextStyle(fontSize: 25),
                              ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Wrap(
                                        spacing: 16,
                                        runSpacing: 16,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [
                                          SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                  .height,
                                              child: GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 10),
                                                  itemCount:
                                                      methodobj.iconID.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return profileimagecontainerwidget(
                                                        Data: methodobj
                                                            .Profiles[index]);
                                                  }))
                                        ])),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ))
          ]));
      }
      return Align(
          alignment: AlignmentDirectional(0, 0),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(30),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: 
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child:
                        Text('${methodobj.isSubscribed != null? "Subscribed": "Free"}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white)),
                      ),
                      ),
                      Text('Status',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                '${methodobj.ProfileImage != null ? methodobj.ProfileImage : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVg_IiPrWq4ijVMk-CA_MovxsvbsOdR8Qwkw&usqp=CAU"}',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: Text('${methodobj.iconID.length}',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white)),
                      ),
                      Text(
                        'Icons',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(0, -1),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child:
                              Text(
                                'My Profile Icons',
                                style: TextStyle(fontSize: 25),
                              ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Wrap(
                                        spacing: 16,
                                        runSpacing: 16,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [
                                          SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                  .height,
                                              child: GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 10),
                                                  itemCount:
                                                      methodobj.iconID.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return profileimagecontainerwidget(
                                                        Data: methodobj
                                                            .Profiles[index]);
                                                  }))
                                        ])),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ))
          ]));
    })));
  }
}
