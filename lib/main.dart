import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_demo/dashboard.dart';
import 'package:google_map_demo/auth/profile_edit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? location;
  Location locationInfo = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  Set<Marker> _markers = {};

  var type  =  [MapType.normal,MapType.satellite,MapType.hybrid,MapType.terrain];
  @override
  void initState() {
    super.initState();
    getLocationPermisstion();
  }
  getLocation()async{
    location = await Geolocator.getCurrentPosition();

    setState(() {

    });
    _markers.add(
        Marker(
            markerId: MarkerId(location!.latitude.toString()+"_"+location!.longitude.toString()+"_"+DateTime.now().toString()),
            position: LatLng(location!.latitude, location!.longitude)
        )
    );
    _markers.add(
        Marker(
            markerId: MarkerId(23.7991631.toString()+"_"+90.4219536.toString()+"_"+DateTime.now().toString()),
            position: LatLng(23.7991631, 90.4219536)
        )
    );
    _markers.add(
        Marker(
            markerId: MarkerId(23.8021213.toString()+"_"+90.4155165.toString()+"_"+DateTime.now().toString()),
            position: LatLng(23.8021213, 90.4155165)
        )
    );
    _markers.add(
        Marker(
            markerId: MarkerId(23.8133624.toString()+"_"+90.4022848.toString()+"_"+DateTime.now().toString()),
            position: LatLng(23.8133624, 90.4022848)
        )
    );


    print(location);
  }
  getLocationPermisstion()async{
    _serviceEnabled = await locationInfo.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationInfo.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationInfo.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationInfo.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashBoard()
    );
  }
}


/// multiple marker add in google map=> done
/// button press to update camera position
/// remove null type value for Position( insert x,y,z)
/// login page imam
/// reg page sumaiya => done
/// profile osman





