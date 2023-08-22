import 'dart:async';
import 'dart:ui';

import 'package:catering/catering/budgeting.dart';
import 'package:catering/catering/drawercatering.dart';
import 'package:catering/catering/setlokasi.dart';
import 'package:catering/home/drawer.dart';
import 'package:catering/pengantar/drawerpengantar.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../globals.dart';
import '../login/services.dart';

class HomePengantarPage extends StatefulWidget {
  const HomePengantarPage({super.key});

  @override
  State<HomePengantarPage> createState() => _HomePengantarPageState();
}

class _HomePengantarPageState extends State<HomePengantarPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: buttonColor,
        centerTitle: true,
      ),
      endDrawer: const Drawer(
        child: DrawerPengantarPage(),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: ScrollController(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  physics: const ClampingScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "OD00000001",
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: darkText,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: buttonColor,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 100,
                                child: const Center(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: Image(
                                      height: 100,
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "lib/assets/images/catering1.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Alisya Catering Berkah",
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        color: darkText,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp 31.500",
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: darkText,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Sedang Dikirim",
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: darkText,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(12),
                                  shape: const CircleBorder(),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MapPengantarPage(),
                                    ),
                                  );
                                },
                                child: Icon(Icons.arrow_forward_rounded),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 5,
                          height: 20,
                        ),
                        const SizedBox(height: 15),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MapPengantarPage extends StatefulWidget {
  const MapPengantarPage({super.key});

  @override
  State<MapPengantarPage> createState() => _MapPengantarPageState();
}

class _MapPengantarPageState extends State<MapPengantarPage> {
  var gmapKey = "AIzaSyBKeLCerzdObJ3yDgjHO-qUpW9fN2-bYkQ";

  late final GoogleMapController? mapController;

  int timerValue = 0;
  Timer? timer;

  LatLng currentLocation = const LatLng(0.0, 0.0);
  LatLng destinationLocation = const LatLng(0.0, 0.0);

  LatLng tapLocation = const LatLng(0.0, 0.0);

  Marker currentMarker = const Marker(
    markerId: MarkerId('current_marker'),
  );
  Marker destinationMarker = const Marker(
    markerId: MarkerId('destination_marker'),
  );

  Set<Polyline> polylines = <Polyline>{};

  final _controllerRadius = TextEditingController();
  String radiusdikirim = "0";

  ServicesUser servicesUser = ServicesUser();
  ServicesCatering servicesCatering = ServicesCatering();
  ServicesPengantar servicesPengantar = ServicesPengantar();

  Future _updateLokasi(id_user, langtitude, longtitude, context) async {
    var response = await servicesPengantar.updateProfileCatering(
        id_user, langtitude, longtitude);
    if (response[0] != 404) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response[1]),
        ),
      );
    }
  }

  Future<void> locationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      openAppSettings();
    } else if (status.isGranted) {
      return;
    }
  }

  Future<void> updateMapRoute() async {
    PolylinePoints polylinePoints = PolylinePoints();

    currentMarker = Marker(
      markerId: const MarkerId('current_marker'),
      position: currentLocation,
    );

    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
      '$gmapKey',
      PointLatLng(
        currentLocation.latitude,
        currentLocation.longitude,
      ),
      PointLatLng(
        destinationLocation.latitude,
        destinationLocation.longitude,
      ),
    );

    if (polylineResult.points.isNotEmpty) {
      List<LatLng> routePoints = [];
      for (var point in polylineResult.points) {
        routePoints.add(
          LatLng(point.latitude, point.longitude),
        );
      }

      bool polylineExists = false;
      Polyline existingPolyline = const Polyline(
        polylineId: PolylineId(''),
      );
      for (Polyline polyline in polylines.toList()) {
        if (polyline.polylineId == const PolylineId('map_route')) {
          polylineExists = true;
          existingPolyline = polyline;
          break;
        }
      }

      if (polylineExists) {
        polylines.remove(existingPolyline);
      }

      polylines.add(
        Polyline(
          polylineId: const PolylineId('map_route'),
          points: routePoints,
          width: 5,
          color: Colors.black,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => _updateLokasi(userID, currentLocation.latitude,
            currentLocation.longitude, context));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    await locationPermission();

    final position = await Geolocator.getCurrentPosition();

    currentLocation = LatLng(position.latitude, position.longitude);
    destinationLocation = const LatLng(-7.276023, 112.782217);

    destinationMarker = Marker(
      markerId: const MarkerId('destination_marker'),
      position: destinationLocation,
    );

    await updateMapRoute();

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentLocation,
          zoom: 15,
        ),
      ),
    );

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((event) {
      currentLocation = LatLng(event.latitude, event.longitude);
      updateMapRoute().whenComplete(() => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: buttonColor,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_outlined)),
      ),
      extendBody: true,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: false,
                  buildingsEnabled: false,
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(markerId: MarkerId("1"), position: currentLocation),
                    Marker(
                        markerId: MarkerId("2"), position: destinationLocation),
                  },
                  polylines: polylines.toSet(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
