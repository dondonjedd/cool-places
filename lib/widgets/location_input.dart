import 'package:cool_places/helpers/location_helper.dart';
import 'package:cool_places/models/place.dart';
import 'package:cool_places/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;
  const LocationInput({super.key, required this.onSelectLocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  late String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude!, longitude: locData.longitude!);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
    widget.onSelectLocation(LatLng(locData.latitude!, locData.longitude!));
  }

  @override
  void initState() {
    // TODO: implement initState
    _previewImageUrl = null;
    super.initState();
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();
    final location = PlaceLocation(
        latitude: locData.latitude!, longitude: locData.longitude!);

    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            builder: ((context) => MapScreen(
                  initialLocation: location,
                  isSelecting: true,
                ))));

    if (selectedLocation == null) {
      return;
    }

    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    print('Selected Location: $selectedLocation');
    widget.onSelectLocation(selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            child: _previewImageUrl == null
                ? const Center(
                    child: Text(
                      'No Location Chosen',
                      textAlign: TextAlign.center,
                    ),
                  )
                : Image.network(
                    _previewImageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select On Map'),
            )
          ],
        )
      ],
    );
  }
}
