import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  late String? _previewImageUrl;

  @override
  void initState() {
    // TODO: implement initState
    _previewImageUrl = null;
    super.initState();
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
              onPressed: () {},
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select On Map'),
            )
          ],
        )
      ],
    );
  }
}
