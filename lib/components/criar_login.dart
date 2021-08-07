import 'dart:ui';

import 'package:app/screens/login/auth_card.dart';

import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 70,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepPurple.shade800,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black54,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          'Pet+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Atom',
                          ),
                        ),
                      ),
                      AuthCard(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
