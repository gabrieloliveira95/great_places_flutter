import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_flutter/models/places.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initalLocation;
  final bool isReadOnly;
  MapScreen({
    this.initalLocation = const PlaceLocation(
      lat: 37.419857,
      long: -122.078827,
    ),
    this.isReadOnly = false,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedPosition;
  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isReadOnly ? 'Map' : 'Select'),
        actions: [
          if (widget.isReadOnly)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        //Specify your API key in the application delegate ios/Runner/AppDelegate.swift
        //Specify your API key in the application manifest android/app/src/main/AndroidManifest.xml
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initalLocation.lat,
            widget.initalLocation.long,
          ),
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: (_pickedPosition == null && !widget.isReadOnly)
            ? null
            : {
                Marker(
                  markerId: MarkerId('P1'),
                  position: _pickedPosition ?? widget.initalLocation.toLatLng(),
                )
              },
      ),
    );
  }
}
