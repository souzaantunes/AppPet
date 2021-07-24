import 'package:flutter/material.dart';


class Transferencia with ChangeNotifier {
  final String id;
  final String nomedoCachorro;
  final String nomeDono;
  final String telefone;
  final String endereco;
  final String pacoteDeBanho;
  final String dataPagamento;
  final double valor;
  // final DateTime datacadastro = DateTime.now();

  Transferencia(
      {this.id,
      this.nomedoCachorro,
      this.nomeDono,
      this.telefone,
      this.endereco,
      this.pacoteDeBanho,
      this.dataPagamento,
      this.valor});

// @override
// String toString() {
//   // TODO: implement toString
//   return 'Transferencia{Animal: $nomedoCachorro,valor: $valor}';
// }
}
