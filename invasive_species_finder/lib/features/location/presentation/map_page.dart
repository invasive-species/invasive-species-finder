import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:invasive_species_finder/features/species/domain/species_collection.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../species/domain/species.dart';

class MapPage extends StatefulWidget {
  MapPage({
    Key? key,
  }) : super(key: key);

  final String title = 'Map';
  static const routeName = '/map';

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _googleMapController;
  late GeolocatorPlatform geolocator;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  List<Marker> markers = [];
  final LatLng _initialPosition = const LatLng(21.300730704104364, -157.81481745653235); // Initial map position

  @override
  void initState() {
    super.initState();
    _requestPermission(context);
    retrievePlaces();
    moveCameraToInitialPosition();
  }

  void moveCameraToInitialPosition() {
    if (_googleMapController != null) {
      _googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(
          _initialPosition,
          14.0,
      ));
    }
  }

  Future<void> _requestPermission(BuildContext context) async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getUserLocation();
    } else if (status.isDenied) {
      _showLocationPermissionDialog(context);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _showLocationPermissionDialog(BuildContext context){
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
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );

      _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 10.0,
        ),
      ));

    } catch (e) {
      print('Error: $e');
    }
  }

  void retrievePlaces() async {
    QuerySnapshot<Map<String, dynamic>> speciesLocations = await FirebaseFirestore.instance.collection('locations').get();
    QuerySnapshot<Map<String, dynamic>> speciesData = await FirebaseFirestore.instance.collection('species').get();

    List<Species> speciesList = speciesData.docs.map((doc){
      return Species.fromJson(doc.data());
    }).toList();

    SpeciesCollection species = SpeciesCollection(speciesList);

    for(QueryDocumentSnapshot<Map<String, dynamic>> speciesLocation in speciesLocations.docs) {
      Map<String, dynamic> data = speciesLocation.data();
      String id = speciesLocation.id;
      String speciesID = data['speciesID'];
      String name = species.getSpeciesName(speciesID);
      double latitude = data['attitude'].toDouble();
      double longitude = data['latitude'].toDouble();
      markers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: name,
          ),
        ),
      );
    }

    if (mounted) {
      setState(() {});
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
          setState(() {
            _controller.complete(controller);
            _googleMapController = controller;
            _getUserLocation();
          });
        },
        markers: Set.from(markers),
        myLocationEnabled: true,
      ),
    );
  }
}
