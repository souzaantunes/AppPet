import 'package:app/providers/Auth.dart';
import 'package:app/providers/transferencias.dart';
import 'package:app/pushNotification/notificacao_Config.dart';
import 'package:app/pushNotification/token.dart';
import 'package:app/screens/App_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Item.dart';

class ListTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListTransferencia> {
  bool _isLoading = true;

  Future<void> _refreshTransferencia(BuildContext context) {
    return Provider.of<Transferencias>(context, listen: false)
        .loadTransferencia();
  }

  @override
  void initState() {
   final Token token  = Token();
    super.initState();
   token.gerarToken().then((Token) => {
   print(token.token),
   });



   new NotificacaoConfig().configure();
    Provider.of<Transferencias>(context, listen: false)
        .loadTransferencia()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final transfer = Provider.of<Transferencias>(context).transferencias;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastros de Banho'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Sair",
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshTransferencia(context),
              child: ListView.builder(
                itemCount: transfer.length,
                itemBuilder: (context, indice) =>
                    ItemTransferencia(transfer[indice]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.PRODUCT_FORM,
          );
        },
      ),
    );
  }
}
