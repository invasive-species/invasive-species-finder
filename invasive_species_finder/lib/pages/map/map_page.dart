import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapView(),
    );
  }
}

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController mapController = MapController();
  final List<LatLng> markers = [
    LatLng(0, 0), // Example marker at (0, 0)
    LatLng(51.5074, -0.1278), // London
    LatLng(40.7128, -74.0060), // New York
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Map View'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: LatLng(0, 0), // Center of the map
          zoom: 2, // Initial zoom level
          onTap: (_) {
            // Handle tap events on the map
          },
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: markers.map((latLng) {
              return Marker(
                width: 80.0,
                height: 80.0,
                point: latLng,
                builder: (ctx) {
                  return Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.blue,
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
