import 'dart:convert';
import 'dart:ui';

import 'package:catering/catering/homecatering.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals.dart';
import '../login/services.dart';
import '../themes/colors.dart';

import 'package:intl/intl.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'dart:math' show asin, atan2, cos, pi, pow, sin, sqrt;

String _idCat = "";
String alamat = "";

class SetLokasiPage extends StatefulWidget {
  const SetLokasiPage({super.key});

  @override
  State<SetLokasiPage> createState() => _SetLokasiPageState();
}

class _SetLokasiPageState extends State<SetLokasiPage> {
  var gmapKey = "AIzaSyCevGSYN9v8XTqy1gUAdrc7jId3XsCYgTM";

  late final GoogleMapController? mapController;

  LatLng currentLocation = const LatLng(0.0, 0.0);
  LatLng destinationLocation = const LatLng(0.0, 0.0);

  LatLng tapLocation = const LatLng(0.0, 0.0);

  Marker currentMarker = const Marker(
    markerId: MarkerId('current_marker'),
  );
  Marker destinationMarker = const Marker(
    markerId: MarkerId('destination_marker'),
  );

  ServicesUser servicesUser = ServicesUser();
  ServicesCatering servicesCatering = ServicesCatering();

  Set<Polyline> polylines = <Polyline>{};

  final _controllerRadius = TextEditingController();
  String radiusdikirim = "0";

  Future<void> locationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      openAppSettings();
    } else if (status.isGranted) {
      return;
    }
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

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentLocation,
          zoom: 20,
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
    });
  }

  Future postSetLokasi(
      id_catering, longtitude, langtitude, radius, context) async {
    var response = await servicesCatering.inputSetLokasi(
        id_catering, longtitude, langtitude, radius);

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

  Future _getProfileCat(id) async {
    var response = await servicesCatering.getProfileCatering(id);
    debugPrint(response[0].toString());
    if (response[0] != 404) {
      debugPrint(response[1].toString());
      _idCat = response[1][0]['id_catering'].toString();
    } else {
      throw "Gagal Mengambil Data";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getProfileCat(userID).whenComplete(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    final apiKey = gmapKey; // Ganti dengan kunci API Google Maps Anda

    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      final results = jsonResult['results'];
      if (results != null && results.isNotEmpty) {
        final addressComponents = results[0]['address_components'];
        List<String> addressParts = [];
        for (var component in addressComponents) {
          addressParts.add(component['long_name']);
        }
        String address = addressParts.join(', ');
        alamat = "a";
        return address;
      }
    }

    return alamat;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: SizedBox(
        width: deviceSize.width,
        height: deviceSize.height,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  GoogleMap(
                    circles: Set<Circle>.of([
                      Circle(
                          strokeWidth: 2,
                          fillColor: Colors.black.withOpacity(0.2),
                          circleId: CircleId('radius'),
                          center: tapLocation,
                          radius: double.parse(radiusdikirim))
                    ]),
                    onTap: (argument) async {
                      tapLocation =
                          LatLng(argument.latitude, argument.longitude);
                      setState(() {});

                      String address = await getAddressFromLatLng(
                          tapLocation.latitude, tapLocation.longitude);
                      print(address);

                      debugPrint(argument.latitude.toString());
                      debugPrint(argument.longitude.toString());
                    },
                    myLocationButtonEnabled: true,
                    myLocationEnabled: false,
                    buildingsEnabled: false,
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: currentLocation,
                      zoom: 20,
                    ),
                    markers: {
                      Marker(
                          markerId: MarkerId("1"), position: currentLocation),
                      Marker(markerId: MarkerId("3"), position: tapLocation),
                      //Marker(markerId: MarkerId("3"), position: tapLocation),
                    },
                    polylines: polylines.toSet(),
                  ),
                  Positioned(
                    top: 30,
                    left: 5,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeCateringPage()),
                        );
                      },
                      fillColor: buttonColor,
                      child: Icon(
                        Icons.arrow_back_outlined,
                        size: 30,
                        color: lightText,
                      ),
                      padding: EdgeInsets.all(13),
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextField(
                        readOnly: false,
                        controller: _controllerRadius,
                        showCursor: true,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 1.5,
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(30, 17, 30, 17),
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          radiusdikirim = _controllerRadius.text;
                          setState(() {});
                        },
                        child: Text(
                          "Set Radius",
                          style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(30, 17, 30, 17),
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          postSetLokasi(_idCat, tapLocation.longitude,
                              tapLocation.latitude, radiusdikirim, context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeCateringPage()),
                          );
                        },
                        child: Text(
                          "Simpan",
                          style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )))
          ],
        ),
      ),
    );
  }
}
