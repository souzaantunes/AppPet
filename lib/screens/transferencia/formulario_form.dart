import 'package:app/models/transferencia.dart';
import 'package:app/providers/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';

import 'package:provider/provider.dart';

class FormularioFormTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioFormTransferenciaState();
  }
}

class FormularioFormTransferenciaState
    extends State<FormularioFormTransferencia> {
  // final _priceFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;
  DateTime _data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final transferencia =
          ModalRoute.of(context).settings.arguments as Transferencia;
      if (transferencia != null) {
        _formData['id'] = transferencia.id;
        _formData['nomedoCachorro'] = transferencia.nomedoCachorro;
        _formData['nomeDono'] = transferencia.nomeDono;
        _formData['telefone'] = transferencia.telefone;
        _formData['endereco'] = transferencia.endereco;
        _formData['pacoteDeBanho'] = transferencia.pacoteDeBanho;
        _formData['dataPagamento'] = transferencia.dataPagamento;
        _formData['valor'] = transferencia.valor;
      } else {
        _formData['valor'] = '';
        _formData['dataPagamento'] = DateTime.now();
      }
    }
  }

  Future<void> _saveForm() async {
    _form.currentState.save();
    final novaTransferencia = Transferencia(
      id: _formData['id'],
      nomedoCachorro: _formData['nomedoCachorro'],
      nomeDono: _formData['nomeDono'],
      telefone: _formData['telefone'],
      endereco: _formData['endereco'],
      pacoteDeBanho: _formData['pacoteDeBanho'],
      dataPagamento: _formData['dataPagamento'],
      valor: _formData['valor'],
    );

    print(novaTransferencia.dataPagamento);

    setState(() {
      _isLoading = true;
    });
    final umaTransferencia =
        Provider.of<Transferencias>(context, listen: false);

    try {
      if (_formData['id'] == null) {
        await umaTransferencia.addTransferencia(novaTransferencia);
      } else {
        await umaTransferencia.updateTransferencia(novaTransferencia);
      }
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Ocorreu um erro!'),
                content: Text('Erro ao salvar o cadastro'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['nomedoCachorro'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome do Pet',
                        icon: Icon(Icons.pets),
                      ),
                      // textInputAction: TextInputAction.next,
                      // onFieldSubmitted: (_) {
                      //   FocusScope.of(context).requestFocus(_priceFocusNode);
                      // },
                      onSaved: (value) => _formData['nomedoCachorro'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['nomeDono'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome do Dono',
                        icon: Icon(Icons.people),
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _formData['nomeDono'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['telefone'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Telefone',
                        icon: Icon(Icons.phone_bluetooth_speaker_rounded),
                      ),
                      onSaved: (value) => _formData['telefone'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['endereco'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Endereço',
                        icon: Icon(Icons.home),
                      ),
                      onSaved: (value) => _formData['endereco'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['pacoteDeBanho'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pacote?',
                        hintText: "Sim/Nao",
                      ),
                      onSaved: (value) => _formData['pacoteDeBanho'] = value,
                    ),
                    DateTimeFormField(

                      initialValue:_formData['dataPagamento'] ,
                       label: "Data",
                        formatter: DateFormat("dd/MM/yyyy"),
                      onSaved: (DateTime value) =>
                          _formData['dataPagamento'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['valor'].toString(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Valor',
                        icon: Icon(Icons.monetization_on),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onSaved: (value) =>
                          _formData['valor'] = double.parse(value),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text('confirmar'),
                      onPressed: () => _saveForm(),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
