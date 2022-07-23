import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/models/directions_model.dart';
import 'package:google_map/screens/login_screen.dart';
import 'package:google_map/utils/marker_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

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
  List<MarkerList> markers = [];
  GoogleMapController? _googleMapController;
  Dio dio = Dio();
  var uuid = Uuid();

  Future getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    currentPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 20);
    _origion = Marker(
        markerId: MarkerId('current'),
        infoWindow: const InfoWindow(title: "Current"),
        position: LatLng(position.latitude, position.longitude));
    //markers.add(MarkerList(_origion!));
    return currentPosition;
  }

  Future<bool> popping() async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Alert"),
                  content: Text("Are you want Sign Out?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                        child: Text("Yes")),
                  ],
                ))) ??
        false;
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
    return WillPopScope(
      onWillPop: popping,
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
              future: markers.isEmpty ? getLocation() : null,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      GoogleMap(
                          mapType: MapType.normal,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                          markers: markers.map((e) => e.marker).toSet(),
                          onTap: (latlng) {
                            final id = uuid.v4();
                            setState(() {
                              markers.add(
                                MarkerList(
                                  Marker(
                                      markerId: MarkerId(id),
                                      infoWindow: InfoWindow(title: id),
                                      position: latlng,
                                      onTap: () {}),
                                ),
                              );
                            });
                            print(
                                markers.map((e) => e.marker.position.latitude));
                            print(markers.map((e) => e.marker.markerId));
                            print(markers.length);
                          },
                          onLongPress: (latlng) {
                            /*
                              print("marker.position.latitude" +
                                  i.marker.position.latitude.toString());
                              print("latlng.latitude:" + latlng.latitude.toString());*/

                            setState(() {
                              markers.removeWhere((element) =>
                                  element.marker.position.latitude
                                          .toStringAsPrecision(6) ==
                                      latlng.latitude.toStringAsPrecision(6) &&
                                  element.marker.position.longitude
                                          .toStringAsPrecision(6) ==
                                      latlng.longitude.toStringAsPrecision(6));
                              print("matched");
                            });
                          },
                          onMapCreated: (controller) {
                            _googleMapController = controller;
                          },
                          initialCameraPosition: currentPosition!),
                      Positioned(
                        top: 30,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                                hintText: "Enter Address",
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 15),
                                suffixIcon: Icon(Icons.search)),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.black,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () async {
              _googleMapController!
                  .animateCamera(CameraUpdate.newCameraPosition(
                currentPosition!,
              ));
            },
            child: const Icon(Icons.center_focus_strong),
          ),
        ),
      ),
    );
  }
}
