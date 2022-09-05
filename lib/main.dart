import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp( MyApp());
  //AIzaSyDmdX2kq_sHbofWZl4HT96SQ1awM7Xzz90
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? location;

  Set<Marker> _markers = {};
  var type  =  MapType.normal;

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
            zoom: 50
          ),
          markers: _markers,
          mapType: type,

        ):Container(
          child: Center(
            child: Text("Loading....."),
          ),
        )

      )
    );
  }
}


/// multiple marker add in google map
/// button press to update camera position
/// remove null type value for Position( insert x,y,z)
/// login page imam
/// reg page sumaiya
/// profile osman





