import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamguh_triva/Statemanagement/cubit/completesignup_cubit.dart';
import 'package:jamguh_triva/pages/widgets/completeusersignup.dart';

class MyHomePage extends StatelessWidget {
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
            ElevatedButton(
              onPressed: () {
                // Add your action for Play Easy
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text('Play Easy', style: TextStyle(fontSize: 40)),
            ),
            SizedBox(height: 200), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                // Add your action for Play Midcore
              },
              style: ElevatedButton.styleFrom(primary: Colors.yellow),
              child: Text(
                'Play Midcore',
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
            ),
            SizedBox(height: 200), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                // Add your action for Play Hardcore
              },
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: Text(
                'Play Hardcore',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
