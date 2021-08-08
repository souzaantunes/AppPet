import 'package:app/models/transferencia.dart';
import 'package:app/providers/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckBoxDeVenda extends StatefulWidget {
  final Transferencia transferencia;

  const CheckBoxDeVenda(this.transferencia);

  @override
  State<StatefulWidget> createState() {
    return _CheckBoxDeVendaState();
  }
}

class _CheckBoxDeVendaState extends State<CheckBoxDeVenda> {
  bool caixa = false;
  bool tr = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: caixa,
      activeColor: Theme.of(context).primaryColor,
      onChanged: (value) async {
        setState(() {
          this.caixa = value;
        });
        this.caixa = !value;
        await Provider.of<Transferencias>(context, listen: false)
            .removeItemList(this.widget.transferencia.id);
      },
    );
  }
}
