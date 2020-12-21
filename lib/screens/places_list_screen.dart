import 'package:flutter/material.dart';
import 'package:great_places_flutter/provider/great_places_provider.dart';
import 'package:great_places_flutter/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Places'), actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.PLACEFORM),
        )
      ]),
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(context, listen: false)
            .loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlacesProvider>(
                child: Center(
                  child: Text('No added Places'),
                ),
                builder: (ctx, greatPlaces, child) => greatPlaces.itemsCount ==
                        0
                    ? child
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.itemByIndex(index).image),
                          ),
                          title: Text(greatPlaces.itemByIndex(index).title),
                          subtitle: Text(
                              greatPlaces.itemByIndex(index).location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.PLACEDETAIL,
                              arguments: greatPlaces.itemByIndex(index),
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
