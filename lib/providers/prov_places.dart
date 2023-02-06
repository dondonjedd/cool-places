import 'dart:io';

import 'package:cool_places/helpers/db_helper.dart';
import 'package:cool_places/helpers/location_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
import 'package:flutter/foundation.dart';

class ProvPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(String title, File image, PlaceLocation loc) async {
    final address = await LocationHelper.getPlaceAddress(
        LatLng(loc.latitude, loc.longitude));
    final updatedLocation = PlaceLocation(
        latitude: loc.latitude, longitude: loc.longitude, address: address);

    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: image);

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address!,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address']),
            image: File(item['image'])))
        .toList();
    notifyListeners();
  }
}
