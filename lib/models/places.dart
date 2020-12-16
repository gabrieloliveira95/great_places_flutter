import 'dart:io';

import 'package:flutter/foundation.dart';

class Places {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
  Places({
    @required this.id,
    @required this.image,
    @required this.location,
    @required this.title,
  });
}

class PlaceLocation {
  final double lat;
  final double long;
  final String adress;
  PlaceLocation({@required this.lat, @required this.long, this.adress});
}
