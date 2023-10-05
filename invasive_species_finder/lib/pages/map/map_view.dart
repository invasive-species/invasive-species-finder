import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithKeyPoints extends StatefulWidget {
  @override
  _MapWithKeyPointsState createState() => _MapWithKeyPointsState();
}

class _MapWithKeyPointsState extends State<MapWithKeyPoints> {
  GoogleMapController _controller;
  final Set<Marker> _markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invasive Species Finder  '),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(34.597280, -93.174930),
          zoom: 12.0, // You can adjust the initial zoom level as needed
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your key points as markers
          _addMarker(
            LatLng(-26.190750, 28.321600),
            'Benoni South Africa',
          );
          _addMarker(
            LatLng(34.693737, 135.502167),
            'Osaka Japan',
          );
          // Add more key points if needed

          // Zoom to fit all markers on the map
          _fitMarkers();
        },
        child: Icon(Icons.add_location),
      ),
    );
  }

  void _addMarker(LatLng position, String markerId) {
    final MarkerId id = MarkerId(markerId);

    final Marker marker = Marker(
      markerId: id,
      position: position,
      infoWindow: InfoWindow(
        title: markerId,
      ),
    );

    setState(() {
      _markers.add(marker);
    });
  }

  void _fitMarkers() {
    LatLngBounds bounds;

    for (var marker in _markers) {
      if (bounds == null) {
        bounds = LatLngBounds(
          southwest: marker.position,
          northeast: marker.position,
        );
      } else {
        bounds = bounds.extend(marker.position);
      }
    }

    if (bounds != null) {
      _controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          bounds,
          50.0, // Padding in pixels
        ),
      );
    }
  }
}
