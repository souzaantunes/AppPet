import 'package:app/models/produto.dart';
import 'package:flutter/material.dart';

class Produtos with ChangeNotifier{
  List<Produto> _items = [];

  List<Produto> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }
  
  
  void addProduto (Produto newProduto){
    
    _items.add(Produto(
        title: newProduto.title,
        price: newProduto.price,
        description: newProduto.description
    ));
    notifyListeners();
  }


}