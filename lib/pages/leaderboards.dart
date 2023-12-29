import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jamguh_triva/Models/leaderboardModel.dart';
import 'package:jamguh_triva/Statemanagement/cubit/leaderboards_manager_cubit.dart';
import 'package:jamguh_triva/pages/widgets/top3.dart';

class Playerleaderboards extends StatelessWidget {
  const Playerleaderboards({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "Leaderboard",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.black, size: 25),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(child:
                BlocBuilder<LeaderboardsManagerCubit, LeaderboardsManagerState>(
              builder: (context, state) {
                var methodobj = context.read<LeaderboardsManagerCubit>();
                if(state is LeaderbaordsManagerDone)
                {
                  return  ListView.builder(
                    shrinkWrap: true,
                          itemCount: methodobj.rebuilt.length,
                          itemBuilder: (context, index) {
                            Leaderboardmodel tile = methodobj.rebuilt[index];
                            return 
                            SizedBox(
                              height: 140,
                              child:
                            ListTile(
                              leading: 
                                  Text('${tile.currentPosition}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  
                              title:Row(children: [ 
                              Gap(15),
                                  Container(
                                    height: 50,
                                    child:
                                        Image.network('${tile.profileImage}'),
                                  ),
                                   Gap(15),
                              Text('${tile.username}'),
                             
                              ]),
                              trailing: Text('${tile.points} Points',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ));
                          });
                }
               return methodobj.rebuilt == 0?
                 FutureBuilder(
                    future: methodobj.getLeaderboard(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error found - ${snapshot.error}');
                        }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Leaderboardmodel tile = snapshot.data![index];
                            return ListTile(
                              leading: Row(
                                children: [
                                  Text('${tile.currentPosition}'),
                                  Gap(15),
                                  Container(
                                    height: 50,
                                    child:
                                        Image.network('${tile.profileImage}'),
                                  ),
                                  Gap(15),
                                ],
                              ),
                              title: Text('${tile.username}'),
                              trailing: Text('${tile.points}'),
                            );
                          });
                    }): CircularProgressIndicator();
                /*
                Column(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 40, left: 25),
                    padding: EdgeInsets.all(25),
                    child: Expanded(
                        child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: [
                        ...methodobj.topthree.map((e) {
                          if (methodobj.topthree.length == 1) {
                            return Topthree(data: e);
                          } else {
                            return Topthree(data: e);
                          }
                        }),
                      ],
                    )),
                  )
                ]);
                */
              },
            ))));
  }
}
