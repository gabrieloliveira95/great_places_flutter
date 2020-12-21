import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  final String address;
  const PlaceLocation({
    @required this.lat,
    @required this.long,
    this.address,
  });

  LatLng toLatLng() {
    return LatLng(this.lat, this.long);
  }
}
