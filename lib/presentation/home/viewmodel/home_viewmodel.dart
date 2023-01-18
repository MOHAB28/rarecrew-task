// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model.dart';

class HomeViewmodel with ChangeNotifier {
  final List<ItemModel> _items = [
    ItemModel(
      id: 'p1',
      title: 'Red Book',
      description: 'Hello I am a red book',
      price: 20.6,
    ),
    ItemModel(
      id: 'p2',
      title: 'Bike',
      description: 'Hello I am a bike. Come and try',
      price: 60.0,
    ),
    ItemModel(
      id: 'p3',
      title: 'Pin',
      description: 'Hello I am a blue pin',
      price: 2.6,
    ),
  ];

  List<ItemModel> get items => [..._items];

  ItemModel findItemById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addItem(ItemInput item) {
    ItemModel newItem = ItemModel(
      id: DateTime.now().toString(),
      title: item.title,
      description: item.description,
      price: item.price,
    );
    _items.add(newItem);
    notifyListeners();
  }

  void updateItem(String id, ItemInput input) {
    int index = _items.indexWhere((element) => element.id == id);
    ItemModel updatedItem = ItemModel(
      id: _items[index].id,
      description: input.description,
      title: input.title,
      price: input.price,
    );
    if (index >= 0) {
      _items[index] = updatedItem;
      notifyListeners();
    }
  }

  void deleteItem(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

class ItemInput {
  final String title;
  final String description;
  final double price;
  const ItemInput({
    required this.title,
    required this.description,
    required this.price,
  });
}

final homeViewmodel =
    ChangeNotifierProvider<HomeViewmodel>((ref) => HomeViewmodel());
