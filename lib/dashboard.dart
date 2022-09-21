import 'package:flutter/material.dart';
import 'package:google_map_demo/map/google_map_page.dart';
import 'package:google_map_demo/home.dart';
import 'package:google_map_demo/auth/profile.dart';
import 'package:location/location.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late PermissionStatus _permissionGranted;
  var _page = [
    Home(),
    GoogleMapPage(),
    Profile()
  ];
  int selectedPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (index){
          selectedPage = index;
          setState(() {

          });
        },
      ),
    );
  }
}
