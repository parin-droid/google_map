import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/models/get_place_id_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

import '../../models/directions_model.dart';
import '../../utils/location_services.dart';
import '../../utils/marker_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = Location();
  CameraPosition? currentPosition;
  bool isLoading = false;
  int selectedIndex = 0;
  Marker? _origion;
  Marker? _destination;
  Directions? _info;
  GetPlaceId? placeIdData;
  List<MarkerList> markers = [];
  List<GetPlaceId> resultList = [];
  GoogleMapController? _googleMapController;
  Dio dio = Dio();
  var uuid = const Uuid();
  TextEditingController searchController = TextEditingController();

  Future getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    currentPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 20);
    _origion = Marker(
        markerId: const MarkerId('current'),
        infoWindow: const InfoWindow(title: "Current"),
        position: LatLng(position.latitude, position.longitude));
    //markers.add(MarkerList(_origion!));
    return currentPosition;
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        print(markers.map((e) => e.marker.position.latitude));
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: searchController,
                              textInputAction: TextInputAction.search,
                              onFieldSubmitted: (value) async {
                                final res =
                                    await LocationServices().getLocation(value);
                                if (res.isNotEmpty) {
                                  setState(() {
                                    resultList = res;
                                    // print("Latlong value");
                                    // // print(res!.placeId);
                                    // print("Latlong value");
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter Address",
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(left: 15, top: 15),
                                  suffixIcon: IconButton(
                                    onPressed: () async {},
                                    icon: const Icon(Icons.search),
                                  )),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: resultList.length,
                                itemBuilder: (_, index) {
                                  final item = resultList[index];
                                  return ListTile(
                                    title: Text(item.description!),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          _googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
            currentPosition!,
          ));
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
