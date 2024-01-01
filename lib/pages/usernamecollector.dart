import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jamguh_triva/Statemanagement/cubit/completesignup_cubit.dart';
import 'package:jamguh_triva/pages/Homepage.dart';

class usernameCollector extends StatelessWidget {
  const usernameCollector({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.read<CompletesignupCubit>();
    return Material(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Create a Username'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<CompletesignupCubit, CompletesignupState>(
          listener: (context, state) {
            if (state is CompletesignupSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              });
            }
          },
          child: Column(children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 16),
              child: TextFormField(
                controller: controller.username,
                textCapitalization: TextCapitalization.sentences,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE0E3E7),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4B39EF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Color(0xCCFFFFFF),
                ),
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF101213),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Gap(15),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
                onSurface: Colors.red,
              ),
              onPressed: () {
                controller.saveUser();
              },
              child: Text('Save Username'),
            )
          ])),
    ));
  }
}
