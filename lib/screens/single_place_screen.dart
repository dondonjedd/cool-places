import 'package:cool_places/providers/prov_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'map_screen.dart';

class SinglePlaceScreen extends StatelessWidget {
  const SinglePlaceScreen({super.key});

  static const routeName = '/single-place-screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;

    final selectedPlace =
        Provider.of<ProvPlaces>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.title)),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location!.address!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push<LatLng>(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: ((context) => MapScreen(
                          initialLocation: selectedPlace.location!,
                          isSelecting: false,
                        ))));
              },
              child: const Text('View On Map'))
        ],
      ),
    );
  }
}
