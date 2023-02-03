import 'package:flutter/cupertino.dart';

import '../models/place.dart';

class ProvPlaces with ChangeNotifier{
  List<Place> _items=[];

  List<Place> get items{
    return [...items];
  }
}