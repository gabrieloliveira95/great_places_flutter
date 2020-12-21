import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_flutter/models/places.dart';
import 'package:great_places_flutter/utils/db_util.dart';
import 'package:great_places_flutter/utils/location.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Places> _items = [];

  Future<void> loadPlaces() async {
    final datalist = await DbUtil.getData('places');
    _items = datalist
        .map((e) => Places(
              id: e['id'],
              title: e['title'],
              image: File(e['image']),
              location: PlaceLocation(
                lat: e['lat'],
                long: e['long'],
                address: e['address'],
              ),
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

  Future<void> addPlace({String title, File image, LatLng position}) async {
    String address = await LocationUtil.getAddressFrom(position);
    final newPlace = Places(
      id: Random().nextDouble().toString(),
      image: image,
      location: PlaceLocation(
        lat: position.latitude,
        long: position.longitude,
        address: address,
      ),
      title: title,
    );
    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': position.latitude,
      'long': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
}
