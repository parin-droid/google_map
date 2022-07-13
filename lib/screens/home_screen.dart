import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/models/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = Location();
  CameraPosition? currentPosition;
  bool isLoading = false;
  Marker? _origion;
  Marker? _destination;
  Directions? _info;
  List<Marker> markers = [];
  GoogleMapController? _googleMapController;

  Future getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    currentPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 20);
    _origion = Marker(
        markerId: MarkerId('current'),
        infoWindow: const InfoWindow(title: "Current"),
        position: LatLng(position.latitude, position.longitude));
    markers.add(_origion!);
    return currentPosition;
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* final CameraPosition _kGooglePlex =
        CameraPosition(target: LatLng(latlong, longlat), zoom: 7.4746);*/
    return Scaffold(
      body: FutureBuilder(
          future: getLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: markers.map((e) => e).toSet(),
                  onTap: (latlng) {
                    setState(() {
                      markers.add(
                        Marker(
                            markerId: MarkerId(latlng.hashCode.toString()),
                            position: latlng),
                      );
                    });
                  },
                  onMapCreated: (controller) {
                    _googleMapController = controller;
                  },
                  initialCameraPosition: currentPosition!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
            currentPosition!,
          ));
        },
        child: Icon(Icons.center_focus_strong),
      ),
    );
  }
}
