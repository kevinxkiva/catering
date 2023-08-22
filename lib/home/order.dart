import 'dart:async';
import 'dart:ui';

import 'package:catering/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login/services.dart';
import '../themes/colors.dart';
import 'drawer.dart';

import 'package:intl/intl.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:math' show asin, atan2, cos, pi, pow, sin, sqrt;

double _long = 0.0;
double _lat = 0.0;

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  DateTime _selectedDate = DateTime.now();
  String _formattedDate = "";
  String _date = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();

  Future<void> selectFilterDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 10, 12, 31),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: buttonColor, // header background color
                onPrimary: lightText, // header text color
                onSurface: darkText, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: buttonColor, // button text color
                ),
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != _selectedDate) {
      if (mounted) {
        setState(() {
          _selectedDate = picked;
          _formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
          _date = _formattedDate;

          setState(() {});
        });
      }
    }
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
      ),
      endDrawer: const Drawer(
        child: DrawerPage(),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: ScrollController(),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    selectFilterDate(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: buttonColor,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _date,
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            color: darkText,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
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
                                          const MapOrderPage(),
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

class MapOrderPage extends StatefulWidget {
  const MapOrderPage({super.key});

  @override
  State<MapOrderPage> createState() => _MapOrderPageState();
}

class _MapOrderPageState extends State<MapOrderPage> {
  var gmapKey = "AIzaSyBKeLCerzdObJ3yDgjHO-qUpW9fN2-bYkQ";

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

  Set<Polyline> polylines = <Polyline>{};

  int timerValue = 0;
  Timer? timer;

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
        _lat,
        _long,
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
          color: Colors.red,
        ),
      );
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    await locationPermission();

    final position = await Geolocator.getCurrentPosition();

    currentLocation = LatLng(position.latitude, position.longitude);
    destinationLocation = LatLng(_lat, _long);

    destinationMarker = Marker(
      markerId: const MarkerId('destination_marker'),
      position: destinationLocation,
    );

    await updateMapRoute();

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_lat, _long),
          zoom: 17,
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

  void openWhatsApp() async {
    String phoneNumber =
        '081914416969'; // Ganti dengan nomor telepon yang diinginkan
    String whatsappUrl = 'https://wa.me/$phoneNumber';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  void openPhoneCall() async {
    String phoneNumber =
        '081914416969'; // Ganti dengan nomor telepon yang diinginkan
    String phoneCallUrl = 'tel:$phoneNumber';

    if (await canLaunch(phoneCallUrl)) {
      await launch(phoneCallUrl);
    } else {
      throw 'Tidak dapat melakukan panggilan';
    }
  }

  ServicesUser servicesUser = ServicesUser();
  ServicesCatering servicesCatering = ServicesCatering();
  ServicesPengantar servicesPengantar = ServicesPengantar();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => _getMapPengantar("US-12"));
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future _getMapPengantar(id) async {
    var response = await servicesUser.getMapPengantar(id);
    debugPrint(response[0].toString());
    if (response[0] != 404) {
      debugPrint(response[1].toString());
      _long = double.parse(response[1][0]['longtitude'].toString());
      _lat = double.parse(response[1][0]['langtitude'].toString());
    } else {
      throw "Gagal Mengambil Data";
    }
    setState(() {});
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
                    circles: Set<Circle>.of([]),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: false,
                    buildingsEnabled: false,
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_lat, _long),
                      zoom: 17,
                    ),
                    markers: {
                      Marker(
                          markerId: MarkerId("1"), position: currentLocation),
                      Marker(
                          markerId: MarkerId("2"),
                          position: LatLng(_lat, _long)),
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
                          MaterialPageRoute(builder: (context) => OrderPage()),
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
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pengantar : ",
                                style: GoogleFonts.inter(
                                  color: darkText,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Anthony",
                                style: GoogleFonts.inter(
                                  color: darkText,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              RawMaterialButton(
                                onPressed: () {
                                  openWhatsApp();
                                },
                                fillColor: buttonColor,
                                child: Icon(
                                  Icons.wechat,
                                  size: 30,
                                  color: lightText,
                                ),
                                padding: EdgeInsets.all(13),
                                shape: CircleBorder(),
                              ),
                              RawMaterialButton(
                                onPressed: () {
                                  openPhoneCall();
                                },
                                fillColor: buttonColor,
                                child: Icon(
                                  Icons.call,
                                  size: 30,
                                  color: lightText,
                                ),
                                padding: EdgeInsets.all(13),
                                shape: CircleBorder(),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Status : Sedang Dikirim",
                          style: GoogleFonts.inter(
                            color: darkText,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      const Divider(
                        thickness: 2,
                        height: 20,
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(40, 14, 40, 14),
                          backgroundColor: lightText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          radiusdikirim = _controllerRadius.text;
                        },
                        child: Text(
                          "Terima",
                          style: GoogleFonts.notoSans(
                            color: buttonColor,
                            fontWeight: FontWeight.w800,
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
