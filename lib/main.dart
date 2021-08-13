import 'package:app/providers/Auth.dart';
import 'package:app/providers/transferencias.dart';
import 'package:app/pushNotification/push_onesignal.dart';
import 'package:app/screens/App_routes.dart';
import 'package:app/screens/home/auth_home_screen.dart';
import 'package:app/screens/transferencia/formulario_form.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() => runApp(PetShopApp());

class PetShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PushOnesignal.config();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Transferencias>(
          create: (_) => new Transferencias(null, null, []),
          update: (ctx, auth, previousTransferencia) => new Transferencias(
            auth.token,
            auth.userId,
            previousTransferencia.transferencias,
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.purple[900],
          accentColor: Colors.deepPurple[100],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.purpleAccent[700],
              textTheme: ButtonTextTheme.primary),
        ),
        routes: {
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => FormularioFormTransferencia(),
        },
      ),
    );
  }
}
