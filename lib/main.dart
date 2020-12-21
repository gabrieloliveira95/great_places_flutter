import 'package:flutter/material.dart';
import 'package:great_places_flutter/provider/great_places_provider.dart';
import 'package:great_places_flutter/screens/place_detail_screen.dart';
import 'package:great_places_flutter/screens/place_form_screen.dart';
import 'package:great_places_flutter/screens/places_list_screen.dart';
import 'package:great_places_flutter/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PLACEFORM: (ctx) => PlaceFormScreen(),
          AppRoutes.PLACEDETAIL: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
