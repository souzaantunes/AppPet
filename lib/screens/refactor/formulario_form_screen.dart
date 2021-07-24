import 'package:app/models/produto.dart';
import 'package:app/screens/refactor/produtos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FormularioFormState();
  }
}

class _FormularioFormState extends State<FormularioFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String , Object>();

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }
  void _saveForm(){
    _form.currentState.save();

    final newProduto= Produto(

      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],

    );
    Provider.of<Produtos>(context, listen: false).addProduto(newProduto);
    Navigator.of(context).pop();
    print(newProduto.id);
    print(newProduto.title);

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
            child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Titulo'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value) => _formData['title']= value,
            ),TextFormField(
              decoration: InputDecoration(labelText: 'preço'),
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              onSaved: (value) => _formData['price']= double.parse(value),
            ),TextFormField(
              decoration: InputDecoration(labelText: 'descriçao'),
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              keyboardType: TextInputType.multiline,
              onSaved: (value) => _formData['description']= (value),
            ),
            RaisedButton (
              child: Text('confirmar'),
              onPressed: () => _saveForm(),
            )
          ],
        )),
      ),
    );
  }
}
