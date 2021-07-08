import 'package:app/screens/login/auth_card.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 117, 255, 05),
                  Color.fromARGB(255, 188, 117, 09),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
            Container(
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
                      'Meu Petshop',
                      style: TextStyle(
                        color:
                            Theme.of(context).accentTextTheme.headline6.color,
                        fontSize: 30,
                        fontFamily: 'Atom',
                      ),
                    ),
                  ),
                  AuthCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
