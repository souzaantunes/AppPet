import 'dart:convert';

import 'package:app/exceptions/http_exception.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/transferencia.dart';

class Transferencias with ChangeNotifier {
  final String _baseUrl =
      'https://flutter-elton-default-rtdb.firebaseio.com/transferencias';
  List<Transferencia> _transferencias = [];

  List<Transferencia> get transferencias => [..._transferencias];
  String _token;
  String _userId;

  Transferencias(this._token, this._userId, this._transferencias);

  int get transferenciasCount {
    return _transferencias.length;
  }

  Future<void> loadTransferencia() async {
    final response = await http.get("$_baseUrl/$_userId.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);
    print(json.decode(response.body));
    _transferencias.clear();
    if (data != null) {
      data.forEach((transferenciaID, transferenciaData) {
        _transferencias.add(
          Transferencia(
            id: transferenciaID,
            nomedoCachorro: transferenciaData['nomedoCachorro'],
            nomeDono: transferenciaData['nomeDono'],
            telefone: transferenciaData['telefone'],
            endereco: transferenciaData['endereco'],
            pacoteDeBanho: transferenciaData['pacoteDeBanho'],
            dataPagamento: transferenciaData['dataPagamento'],
            valor: transferenciaData['valor'],
          ),
        );
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addTransferencia(Transferencia newTransfer) async {
    final response = await http.post(
      "$_baseUrl/$_userId.json?auth=$_token",
      body: json.encode({
        'nomedoCachorro': newTransfer.nomedoCachorro,
        'nomeDono': newTransfer.nomeDono,
        'telefone': newTransfer.telefone,
        'endereco': newTransfer.endereco,
        'pacoteDeBanho': newTransfer.pacoteDeBanho,
        'dataPagamento': newTransfer.dataPagamento,
        'valor': newTransfer.valor,
      }),
    );
    if(response.statusCode.isNegative){
      _transferencias.add(
        Transferencia(
          id: json.decode(response.body)['name'],
          nomedoCachorro: newTransfer.nomedoCachorro,
          nomeDono: newTransfer.nomeDono,
          telefone: newTransfer.telefone,
          endereco: newTransfer.endereco,
          pacoteDeBanho: newTransfer.pacoteDeBanho,
          dataPagamento: newTransfer.dataPagamento,
          valor: newTransfer.valor,
        ),
      );
    } else{
      print("Erro de banco");
    }
    notifyListeners();
  }

  Future<void> updateTransferencia(Transferencia transferencia) async {
    if (transferencia == null || transferencia.id == null) {
      return;
    }
    final index = _transferencias
        .indexWhere((transfer) => transfer.id == transferencia.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/$_userId/${transferencia.id}.json?auth=$_token",
        body: json.encode({
          'nomedoCachorro': transferencia.nomedoCachorro,
          'nomeDono': transferencia.nomeDono,
          'telefone': transferencia.telefone,
          'endereco': transferencia.endereco,
          'pacoteDeBanho': transferencia.pacoteDeBanho,
          'dataPagamento': transferencia.dataPagamento,
          'valor': transferencia.valor,
        }),
      );
      _transferencias[index] = transferencia;
      notifyListeners();
    }
  }

  Future<void> deleteTransferencia(String id) async {
    final index = _transferencias.indexWhere((transfer) => transfer.id == id);
    if (index >= 0) {
      final transferencias = _transferencias[index];
      _transferencias.remove(transferencias);
      notifyListeners();
      final response = await http
          .delete("$_baseUrl/$_userId/${transferencias.id}.json?auth=$_token");
      if (response.statusCode >= 400) {
        _transferencias.insert(index, transferencias);
        notifyListeners();
        throw HttpException('Ocorreu um problena na exclusao do Cdastro');
      }
      // _transferencias.removeWhere((transfer) => transfer.id == id);
    }
  }
}
