import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:qutation/classes/quote.dart';

class ProvLoaded extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Quote> _items= [];
  int num =0;

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Quote> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
 // int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Quote item) {
    // int check =0;
    // ///check if the quote is already loaded or not
    // if(_items.length >0){
    // for(int i =0; i <= _items.length ; i++){
    //   if(item.id == _items[i].id){
    //     check=-1;
    //   }
    // }}
    // if(check == 0){
    _items.add(item);

  //}
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  List<Quote> getLoadedQ(){
    notifyListeners();
    return _items;

  }




}