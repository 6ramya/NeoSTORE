import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StoreLocator extends StatefulWidget {
  const StoreLocator({Key? key}) : super(key: key);

  @override
  _StoreLocatorState createState() => _StoreLocatorState();
}

class _StoreLocatorState extends State<StoreLocator> {
  late GoogleMapController _controller;
  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(19.059984, 72.889999), zoom: 11);

  List<Marker> markers = [
    Marker(markerId: MarkerId('id1'), position: LatLng(19.0596, 72.8295)),
    Marker(markerId: MarkerId('id2'), position: LatLng(19.1663, 72.8526)),
    Marker(markerId: MarkerId('id3'), position: LatLng(19.1726, 72.9425)),
    Marker(markerId: MarkerId('id4'), position: LatLng(19.1136, 72.8697)),
    Marker(markerId: MarkerId('id5'), position: LatLng(19.0522, 72.9005)),
  ];
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController _controller) {
    setState(() {
      _markers.addAll(markers);
    });
  }

  List<String> store_names = [
    'SKYLAND STORE',
    'WOODMOUNT STORE',
    'NATUFUR STORE',
    'LAVANDER STORE',
    'FURNIMATT STORE'
  ];

  List<String> addr = [
    '6335 Edgewood Road Reisterstowm, MD 21136',
    '9437 Pin Oak Drive South Plainfield, NJ 07080',
    '3789 Pennysylvania Avenue Brandon, FL 33510',
    '9311 Garfield Avenue Hamburg, NY 14075',
    '7346 Hanover Court Arlington, MA 02474'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(height: 300, child: buildMap()),
        Expanded(
          child: ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) => Divider(color: Colors.grey),
              itemBuilder: (context, index) {
                return buildTile(
                    storeName: store_names[index], address: addr[index]);
              }),
        ),
      ],
    ));
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      onMapCreated: _onMapCreated,
      markers: _markers,
    );
  }

  Widget buildTile({String? storeName, String? address}) {
    return ListTile(
      leading:
          Icon(MdiIcons.mapMarkerRadius, color: Colors.grey[800], size: 84 / 3),
      title: Text('$storeName'),
      subtitle: Text('$address'),
    );
  }
}
