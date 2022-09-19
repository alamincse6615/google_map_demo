import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_demo/auth/profile_edit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Position? location;

  Set<Marker> _markers = {};

  var type  =  [MapType.normal,MapType.satellite,MapType.hybrid,MapType.terrain];
  @override
  void initState() {
    super.initState();
    getLocation();

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: location!=null?GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    location!.latitude,
                    location!.longitude
                ),

              ),
              markers: _markers,
              mapType: MapType.satellite

          ):Container(
            child: Center(
              child: Text("Loading....."),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              setState(() {
                location;
              });
            },
            child: const Icon(Icons.location_searching_rounded),
          ),

        )
    );
  }
}