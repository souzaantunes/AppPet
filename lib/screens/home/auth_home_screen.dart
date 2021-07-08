import 'package:app/components/cira%C3%A7ao_login.dart';
import 'package:app/providers/Auth.dart';
import 'package:app/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    Auth auth = Provider.of(context);

   return auth.isAuth ? ListTransferencia() : TelaLogin();
  }

}