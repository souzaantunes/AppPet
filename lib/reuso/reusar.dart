// onPressed: () {
// Navigator.push(context, MaterialPageRoute(builder: (context) {
// return FormularioTransferencia();
// })).then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
// },



//
//
//
// class FormularioTransferenciaState extends State<FormularioTransferencia>{
//   final TextEditingController _controladorCampoNumeroConta =
//   TextEditingController();
//   final TextEditingController _controladorCampoValor = TextEditingController();
//   final TextEditingController _controllerCampoNomePet = TextEditingController();
//   final TextEditingController _controllerCampoNomeDono = TextEditingController();
//   final TextEditingController _controllerCampoCPF = TextEditingController();
//   final TextEditingController _controllerCampoTelefone = TextEditingController();
//   final TextEditingController _controllerCampoBairro = TextEditingController();
//   final TextEditingController _controllerCampoCep = TextEditingController();
//   final TextEditingController _controllerCampoRua = TextEditingController();
//   final TextEditingController _controllerCampoData = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cadastro'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             child: ListView(
//               children: <Widget>[
//                 TextFormField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Numero da conta',
//                     hintText: '0000',
//                   ),
//                   textInputAction: TextInputAction.next,
//                   onFieldSubmitted: (_){
//                     // FocusScope.of(context).requestFocus(_priceFocusNode);
//                   },
//                 ),
//                 TextFormField(
//                     controlador: _controladorCampoValor,
//                     rotulo: 'Valor',
//                     dica: '0.00',
//                     icone: Icons.monetization_on),
//                 Editor(
//                     controlador: _controllerCampoNomePet,
//                     rotulo: 'Nome do Pet',
//                     icone: Icons.pets),
//                 Editor(
//                     controlador: _controllerCampoNomeDono,
//                     rotulo: 'Nome do Dono',
//                     icone: Icons.people),
//                 Editor(
//                     controlador: _controllerCampoCPF,
//                     rotulo: 'CPF',
//
//                     icone: Icons.text_snippet),
//                 Editor(
//                     controlador: _controllerCampoTelefone,
//                     rotulo: 'Telefone',
//
//                     icone: Icons.phone_bluetooth_speaker_rounded),
//
//                 Editor(
//                     controlador: _controllerCampoCep,
//                     rotulo: 'Seu CEP',
//
//                     icone: Icons.home_work
//                 ),
//
//                 Editor(
//                     controlador: _controllerCampoBairro,
//                     rotulo: 'Seu Bairro',
//
//                     icone: Icons.home
//                 ),
//                 Editor(
//                     controlador: _controllerCampoRua,
//                     rotulo: 'Rua',
//
//                     icone: Icons.home
//                 ),
//                 Editor(
//                     controlador: _controllerCampoData,
//                     rotulo: 'Data',
//
//                     icone: Icons.date_range
//                 ),
//                 // ignore: deprecated_member_use
//                 RaisedButton (
//                   child: Text('confirmar'),
//                   onPressed: () => _criaTransferencia(context),
//                 )
//               ],
//             ),
//           ),
//         ),),
//     );
//   }
//
//   void _criaTransferencia(BuildContext context) {
//     final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
//     final double valor = double.tryParse(_controladorCampoValor.text);
//     final String nomePet = (_controllerCampoNomePet.text);
//     final String nomeDono = (_controllerCampoNomeDono.text);
//     final String cpf = (_controllerCampoCPF.text);
//     final String telefone= (_controllerCampoTelefone.text);
//     final String bairro = (_controllerCampoBairro.text);
//     final String cep = (_controllerCampoCep.text);
//     final String rua = (_controllerCampoRua.text);
//     final String data = (_controllerCampoData.text);
//
//     if (numeroConta != null && valor != null) {
//       final transferenciaCriada = Transferencia(numeroConta, valor,nomePet,nomeDono,cpf,cep,bairro,data,rua,telefone);
//
//       debugPrint('Criando transferência');
//       debugPrint('$transferenciaCriada');
//       Navigator.pop(context, transferenciaCriada);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('$transferenciaCriada'),
//           ));
//     }
//   }



//
// class ListTransferencia extends StatefulWidget {
//   final List<Transferencia> _transferencia = [];
//
//   @override
//   State<StatefulWidget> createState() {
//     return ListaTransferenciaState();
//   }
// }
//
// class ListaTransferenciaState extends State<ListTransferencia> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cadastros de Banho'),
//       ),
//       body: ListView.builder(
//         itemCount: widget._transferencia.length,
//         itemBuilder: (context, indice) {
//           final transferencia = widget._transferencia[indice];
//
//           return ItemTransferencia(transferencia);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.of(context).pushNamed(
//             AppRoutes.PRODUCT_FORM,
//             // FormularioTransferencia();
//           ).then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
//         },
//       ),
//     );
//   }
//
//   void _atualiza(Transferencia transferenciaRecebida) {
//     if (transferenciaRecebida != null) {
//       setState(() {
//         widget._transferencia.add(transferenciaRecebida);
//       });
//     }
//   }
//
// }


