import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationTracking extends StatefulWidget {
  const LocationTracking({Key? key}) : super(key: key);

  @override
  State<LocationTracking> createState() => _LocationTrackingState();
}

class _LocationTrackingState extends State<LocationTracking> {
  final Completer<GoogleMapController> controller = Completer();

  static const LatLng sourceLocation = LatLng(31.5204, 74.3587);
  static const LatLng destination = LatLng(34.1688, 73.2215);

  List<LatLng> polylineCoordinates= [];
  LocationData? currentLocation;
  void getCurrentLocation(){
    Location location = Location();

    location.getLocation().then((value) => currentLocation = value);
  }
  void getPolyPoints() async{
    PolylinePoints polylinepoints = PolylinePoints();

    PolylineResult results = await polylinepoints.getRouteBetweenCoordinates(
      'AIzaSyB_EPSE8eUI9s74Sh7oNymkyMt34HPotys',
      PointLatLng(sourceLocation.latitude,sourceLocation.longitude),
      PointLatLng(destination.latitude,destination.longitude),
    );
    if(results.points.isNotEmpty){
      results.points.forEach((PointLatLng point)=>polylineCoordinates.add(
        LatLng(point.latitude,point.longitude),
        ),
      );
      setState(() {
        Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
            color: Colors.black,
            width: 5
        );
      });
    }
  }
  @override
  void initState(){
    getCurrentLocation();
    getPolyPoints();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Tracker"),
      ),
      body: (currentLocation==null)?
          const Text("Loading...")
          :GoogleMap(
        initialCameraPosition: CameraPosition(
            target: sourceLocation,
            zoom: 13.5
        ),
        polylines: {
          Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
              color: Colors.black,
              width: 5
          )
        },
        markers: {

          const Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          const Marker(
            markerId: MarkerId("destination"),
            position: destination,
          ),
        },
      )
    );
  }
}
