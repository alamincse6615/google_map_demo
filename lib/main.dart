import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_demo/profile_edit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp( MyApp());

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? location;

  Set<Marker> _markers = {};
<<<<<<< HEAD
  var type  =  MapType.normal;
=======
  var type  =  [MapType.normal,MapType.satellite,MapType.hybrid,MapType.terrain];

>>>>>>> ac69e8de752e7ef84d572a414078f7182a0ea9d9
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


/// multiple marker add in google map=> done
/// button press to update camera position
/// remove null type value for Position( insert x,y,z)
/// login page imam
/// reg page sumaiya => done
/// profile osman





