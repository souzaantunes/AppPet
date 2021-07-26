import 'package:app/exceptions/http_exception.dart';
import 'package:app/models/transferencia.dart';
import 'package:app/providers/transferencias.dart';
import 'package:app/screens/App_routes.dart';
import 'package:app/util/DateUtil.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  // Color cor = Colors.green;





  const ItemTransferencia(this._transferencia);

  void _selectTransferencia(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.PRODUCT_FORM,
      arguments: _transferencia,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateUtil dataHoje = new DateUtil();
    final scaffold = Scaffold.of(context);
   Color cor = Colors.green;
      var dataPagamento = _transferencia.dataPagamento;
      var formatData = dataHoje.formatDataDay();
      if (formatData == dataPagamento) {cor = Colors.redAccent;}
    return Card(
          child:
        ListTile(
      onTap: () => _selectTransferencia(context),
      leading: Icon(Icons.account_circle),
      title: Text(_transferencia.nomeDono.toString()),
      subtitle: Text(_transferencia.dataPagamento.toString(),
          style:
          TextStyle(color: cor)),
      // trailing: Text(_transferencia.dataPagamento.toString()),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCT_FORM,
                    arguments: _transferencia,
                  );
                }),
            IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Excluir"),
                      content: Text('Tem certeza?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Nao'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        FlatButton(
                          child: Text('sim'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    ),
                  ).then(
                    (value) async {
                      if (value) {
                        try {
                          await Provider.of<Transferencias>(context, listen: false)
                              .deleteTransferencia(_transferencia.id);
                        } on HttpException catch (error) {
                          scaffold.showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                            ),
                          );
                        }
                      }
                    },
                  );
                }),
          ],
        ),
      ),
    ));
  }
}
