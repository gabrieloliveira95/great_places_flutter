import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_flutter/screens/map_screen.dart';
import 'package:great_places_flutter/utils/location.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;
  LocationInput(this.onSelectPosition);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double long) {
    final mapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: long,
    );
    setState(() {
      _previewImageUrl = mapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      print(locData.latitude);
      print(locData.longitude);
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPosition(LatLng(locData.latitude, locData.longitude));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(),
      ),
    );
    if (selectedPosition == null) {
      return;
    }

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);

    print(selectedPosition.latitude);
    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text('No Location Set')
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Location'),
              onPressed: _getCurrentUserLocation,
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select'),
              onPressed: _selectOnMap,
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
