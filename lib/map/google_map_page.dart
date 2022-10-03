import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_demo/auth/profile_edit.dart';
import 'package:google_map_demo/model/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Position? location;
  LatLng _latLng =  LatLng(23.56, 90.45);
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  late UserModel _userModel;
  List<UserModel> userList = [];
  late CameraUpdate cameraUpdate;

  var type  =  [MapType.normal,MapType.satellite,MapType.hybrid,MapType.terrain];
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getUserData();


  }


  void getUserData()async{
    FirebaseDatabase.instance.ref("Users").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map,);
      data.forEach((key, value) {
        _userModel = UserModel.fromJson(value);
        userList.add(_userModel);
      });
      setState(() {
        print(userList);
        getLocation();
      });
    });
  }

  CameraPosition _kGoogle = CameraPosition(
    target: LatLng(23.89, 90.10),
    zoom: 14.4746,
  );

  getCurrentLocation()async{
    var currentLocation = await Geolocator.getCurrentPosition();
    _latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
    _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: _latLng, zoom: 17)
          //17 is new zoom level
        )
    );
    setState(() {

    });
  }

  getLocation()async{
    location = await Geolocator.getCurrentPosition();
    setState(() {

    });
    _latLng = LatLng(location!.latitude, location!.longitude);
    _markers.add(
        Marker(
            infoWindow: InfoWindow(title: "I'm here "),

            markerId: MarkerId(location!.latitude.toString()+"_"+location!.longitude.toString()+"_"+DateTime.now().toString()),
            position: LatLng(location!.latitude, location!.longitude)
        )
    );
    for(var item in userList){
      _markers.add(
          Marker(
              infoWindow: InfoWindow(title: item.name.toString()+" "+item.userEmail.toString()),
              onTap: (){
                  print(item.userEmail);
              },
              markerId: MarkerId(item.uid.toString()),
              position: LatLng(double.parse(item.lat.toString()), double.parse(item.lon.toString()))
          )
      );
    }
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: location!=null?GoogleMap(
              onMapCreated:(GoogleMapController controller){
                _controller = controller;
              },
              initialCameraPosition: _kGoogle,
              markers: _markers,
              mapType: MapType.normal,

          ):Container(
            child: Center(
              child: Text("Loading....."),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              getCurrentLocation();
            },
            child: const Icon(Icons.location_searching_rounded),
          ),

        )
    );
  }
}