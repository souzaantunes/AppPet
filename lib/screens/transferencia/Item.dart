import 'package:app/components/check_box.dart';
import 'package:app/models/transferencia.dart';
import 'package:app/screens/App_routes.dart';
import 'package:app/screens/transferencia/lista.dart';
import 'package:app/util/DateUtil.dart';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

  void _selectTransferencia(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.PRODUCT_FORM,
      arguments: _transferencia,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool alerta = false;
    final DateUtil dataHoje = new DateUtil();
    Color cordata = Colors.green;
    var dataPagamento = _transferencia.dataPagamento;
    var formatData = dataHoje.formatDataDay();
    if (formatData == dataPagamento) {
      cordata = Colors.redAccent;
      alerta = true;
    }

    return Card(
        child: ListTile(
      onTap: () => _selectTransferencia(context),
      leading: CheckBoxDeVenda(_transferencia),
      title: Text(_transferencia.nomeDono.toString()),
      subtitle: Text(_transferencia.dataPagamento.toString(),
          style: TextStyle(color: cordata)),
      trailing: Container(
        alignment: Alignment.centerLeft,
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                alignment: Alignment.centerLeft,
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCT_FORM,
                    arguments: _transferencia,
                  );
                }),
          ],
        ),
      ),
    ));
  }
}
