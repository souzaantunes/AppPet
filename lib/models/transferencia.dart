import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transferencia with ChangeNotifier {
  final String id;
  final String nomedoCachorro;
  final String nomeDono;
  final String telefone;
  final String endereco;
  final String pacoteDeBanho;
  final DateTime dataPagamento;
  final double valor;
  final DateTime datacadastro = DateTime.now();

  Transferencia(
      {
        this.id,
        this.nomedoCachorro,
      this.nomeDono,
      this.telefone,
      this.endereco,
      this.pacoteDeBanho,
      this.dataPagamento,
      this.valor});

      String formatData(DateTime data) {

       return DateFormat('dd/MM/yyyy').format(data);


    }


    DateTime parseData(String data){
      return DateTime.parse(data);
    }



  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return 'Transferencia{Animal: $nomedoCachorro,valor: $valor}';
  // }
}
