import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  final String title = 'Map';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _googleMapController;
  late GeolocatorPlatform geolocator;

  @override
  void initState() {
    super.initState();
    _requestPermission(context);
  }

  Future<void> _requestPermission(BuildContext context) async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getUserLocation();
    } else if (status.isDenied) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Location Permission'),
              content: const Text('Please enable location services to use this feature.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );}
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );

      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 10.0,
        ),
      ));

    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(21.4389, -158.0001), // Initial map location to Oahu, Hawaii
          zoom: 10.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _googleMapController = controller;
        },
      ),
    );
  }
}
