import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:great_places_flutter/models/places.dart';
import 'package:great_places_flutter/utils/db_util.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Places> _items = [];

  Future<void> loadPlaces() async {
    final datalist = await DbUtil.getData('places');
    _items = datalist
        .map((e) => Places(
              id: e['id'],
              title: e['title'],
              image: File(e['image']),
              location: null,
            ))
        .toList();
    notifyListeners();
  }

  List<Places> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Places itemByIndex(index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Places(
      id: Random().nextDouble().toString(),
      image: image,
      location: null,
      title: title,
    );
    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
    notifyListeners();
  }
}
