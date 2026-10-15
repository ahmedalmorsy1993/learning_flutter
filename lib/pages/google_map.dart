import 'dart:async';

import 'package:first_app/geo_locator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 12.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );
  Set<Marker> markers = {
    Marker(markerId: const MarkerId('1'), position: _kLake.target),
  };
  StreamSubscription<Position>? _positionSub;
  @override
  void initState() {
    super.initState();
    CustomGeolocator.determinePosition().then((position) {
      if (mounted) _moveMarker(position);
    });
    _positionSub = CustomGeolocator.getPositionStream().listen((
      position,
    ) async {
      if (!mounted) return;
      _moveMarker(position);
      final controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
      );
    });
  }

  // Replace the marker instead of adding: Marker equality includes position,
  // so `add` kept growing the set with every location update.
  void _moveMarker(Position position) {
    setState(() {
      markers = {
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(position.latitude, position.longitude),
        ),
      };
    });
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        // onTap: (LatLng latlng) => setState(() {
        //   markers.add(
        //     Marker(
        //       markerId: MarkerId(latlng.hashCode.toString()),
        //       position: latlng,
        //     ),
        //   );
        // }),
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        markers: markers,
        markerType: GoogleMapMarkerType.marker,
        // markers: ,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
