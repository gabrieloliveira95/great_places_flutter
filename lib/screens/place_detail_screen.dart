import 'package:flutter/material.dart';
import 'package:great_places_flutter/models/places.dart';
import 'package:great_places_flutter/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Places _place = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(_place.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              _place.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            _place.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 10),
          FlatButton.icon(
            icon: Icon(Icons.map),
            label: Text('See on Map'),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                  isReadOnly: true,
                  initalLocation: _place.location,
                ),
              ));
            },
          )
        ],
      ),
    );
  }
}
