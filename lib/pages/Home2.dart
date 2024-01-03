import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamguh_triva/Statemanagement/cubit/completesignup_cubit.dart';
import 'package:jamguh_triva/pages/widgets/completeusersignup.dart';

class MyHomePageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CompletesignupCubit, CompletesignupState>(
        builder: (context, state) {
      if (state is CompletesignupRequest) {
        return const completeUserSignup();
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image.asset(
                    "assets/images/jamaica_flag_brushStroke.png"),
            const Text("Select Difficulty"),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) => SizedBox(
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Column(
                        children: [
                          Text(
                            "Beginner",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text("1 point per answer", style: TextStyle(color: Color.fromARGB(255, 102, 102, 102), fontSize: 12),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }));
  }
}
