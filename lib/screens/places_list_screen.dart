import 'package:cool_places/providers/prov_places.dart';
import 'package:cool_places/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cool Places"), actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add))
      ]),
      body: Consumer<ProvPlaces>(
        child: const Center(
          child: Text('No places yet. Add some!'),
        ),
        builder: (ctx, coolPlaces, ch) => coolPlaces.items.isEmpty
            ? ch!
            : ListView.builder(
                itemCount: coolPlaces.items.length,
                itemBuilder: (ctx, i) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(coolPlaces.items[i].image),
                      ),
                      title: Text(coolPlaces.items[i].title),
                      onTap: () {},
                    )),
      ),
    );
  }
}
