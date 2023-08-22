import 'dart:convert';
import 'dart:io';
import 'dart:ffi';
import 'dart:ui';
import 'package:catering/globals.dart';
import 'package:intl/intl.dart';

import 'package:catering/login/services.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:math' show asin, atan2, cos, pi, pow, sin, sqrt;

int angkacek = 0;
double _long = 0.0;
double _lat = 0.0;
int _radius = 0;

String namaDetail = "";
String alamatDetail = "";
String deskripsiDetail = "";

String _idCat = "";
double distance = 0.0;

String cek = "";

final List _idMenuList = [];
final List _namaMenuList = [];
final List _hargaMenuList = [];
final List _tanggalMenuList = [];

String globalLong = "";
String globalLat = "";

String alamat = "";

class ListCateringPage extends StatefulWidget {
  final String type;
  const ListCateringPage(
      {Key? key, required this.type})
      : super(key: key);

  @override
  State<ListCateringPage> createState() => _ListCateringPageState();
}

class _ListCateringPageState extends State<ListCateringPage> {
  late Future getAllCatering;
  ServicesUser servicesUserAllCat = ServicesUser();

  @override
  void initState() {
    // TODO: implement initState
    getAllCatering = servicesUserAllCat.getAllCatering();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: deviceWidth,
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage("lib/assets/images/geprek.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightText,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_outlined,
                    color: buttonColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.type,
                  style: GoogleFonts.inter(
                      fontSize: 28,
                      color: buttonColor,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 15),
                Text(
                  "Ayo Lihat " + widget.type + " Catering Yuk, Ada Banyak Lohhh...",
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      color: buttonColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 10,
            color: Colors.grey,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
              child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: ScrollController(),
                  child: FutureBuilder(
                    future: getAllCatering,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List snapData = snapshot.data! as List;
                        if (snapData[0] != 404) {
                          return ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              },
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              controller: ScrollController(),
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapData[1].length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _idCat = snapData[1][index]['id_catering']
                                        .toString();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailCateringPage(),
                                      ),
                                    ).whenComplete(() => setState(() {}));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: buttonColor,
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              height: 100,
                                              child: const Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
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
                                            SizedBox(width: 25),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapData[1][index]
                                                          ['nama_catering']
                                                      .toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      color: darkText,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapData[1][index]
                                                          ['alamat_catering']
                                                      .toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      color: darkText,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      snapData[1][index]
                                                              ['tipe_pemesanan']
                                                          .toString()
                                                          .replaceAll("[", "")
                                                          .replaceAll("]", ""),
                                                      style: GoogleFonts.inter(
                                                          fontSize: 14,
                                                          color: darkText,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: buttonColor,
                                                      size: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "5",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 15,
                                                          color: darkText,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }
                      return Column();
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailCateringPage extends StatefulWidget {
  const DetailCateringPage({super.key});

  @override
  State<DetailCateringPage> createState() => _DetailCateringPageState();
}

class _DetailCateringPageState extends State<DetailCateringPage> {
  bool cekDropdown = false;
  Color cekWarna = Colors.grey;
  bool cekWarna2 = false;

  var gmapKey = "AIzaSyCevGSYN9v8XTqy1gUAdrc7jId3XsCYgTM";

  late final GoogleMapController? mapController;

  LatLng currentLocation = const LatLng(0.0, 0.0);

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

  DateTime _selectedDateStart = DateTime.now();
  String _formattedDateStart = "";
  String _dateStart = "";

  DateTime _selectedDateEnd = DateTime.now();
  String _formattedDateEnd = "";
  String _dateEnd = "";

  bool tambah = false;

  List<String> _tipePem = List.empty(growable: true);
  List<int> _count = List.generate(0, (index) => 0);

  ServicesUser servicesUser = ServicesUser();
  ServicesCatering servicesCatering = ServicesCatering();
  ServicesPengantar servicesPengantar = ServicesPengantar();

  Future<void> selectFilterDateStart(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateStart,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10, 12, 31),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: buttonColor,
                onPrimary: lightText,
                onSurface: darkText,
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
    if (picked != null && picked != _selectedDateStart) {
      if (mounted) {
        _selectedDateStart = picked;
        _formattedDateStart =
            DateFormat('dd-MM-yyyy').format(_selectedDateStart);
        _dateStart = _formattedDateStart;

        setState(() {});
      }
    }
  }

  Future<void> selectFilterDateEnd(context, tipeApa) async {
    if (tipeApa == "Mingguan") {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDateStart,
        firstDate: _selectedDateStart,
        lastDate: DateTime(_selectedDateStart.year, _selectedDateStart.month,
            _selectedDateStart.day + 7),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: buttonColor,
                  onPrimary: lightText,
                  onSurface: darkText,
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
      if (picked != null && picked != _selectedDateEnd) {
        if (mounted) {
          _selectedDateEnd = picked;
          _formattedDateEnd = DateFormat('dd-MM-yyyy').format(_selectedDateEnd);
          _dateEnd = _formattedDateEnd;

          setState(() {});
        }
      }
    }
    if (tipeApa == "Bulanan") {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDateStart,
        firstDate: _selectedDateStart,
        lastDate: DateTime(_selectedDateStart.year,
            _selectedDateStart.month + 1, _selectedDateStart.day),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: buttonColor,
                  onPrimary: lightText,
                  onSurface: darkText,
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
      if (picked != null && picked != _selectedDateEnd) {
        if (mounted) {
          _selectedDateEnd = picked;
          _formattedDateEnd = DateFormat('dd-MM-yyyy').format(_selectedDateEnd);
          _dateEnd = _formattedDateEnd;

          setState(() {});
        }
      }
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

  Future _getMap(id) async {
    var response = await servicesUser.getCekMaps(id);
    debugPrint(response[0].toString());
    if (response[0] != 404) {
      debugPrint(response[1].toString());
      _long = double.parse(response[1][0]['longtitude'].toString());
      _lat = double.parse(response[1][0]['langtitude'].toString());
      _radius = response[1][0]['radius'];
      debugPrint(_lat.toString());
      debugPrint(_long.toString());
      debugPrint(_radius.toString());
    } else {
      throw "Gagal Mengambil Data";
    }
    setState(() {});
  }

  Future _getDetailCat(id) async {
    var response = await servicesUser.getDetailCatering(id);
    debugPrint(response[0].toString());
    if (response[0] != 404) {
      debugPrint(response[1].toString());
      namaDetail = response[1][0]['nama_catering'].toString();
      alamatDetail = response[1][0]['alamat_catering'].toString();
      deskripsiDetail = response[1][0]['deskripsi_catering'].toString();
      for (var element in response[1][0]['tipe_pemesanan']) {
        _tipePem.add(element);
      }
    } else {
      throw "Gagal Mengambil Data";
    }
    setState(() {});
  }

  late Future getAllMenu;
  ServicesCatering servicesCat = ServicesCatering();

  String _dateMenu = "";

  @override
  void initState() {
    
    getAllMenu = servicesCat.getMenuCatering(_idCat, "29-05-2023");
    _getMap(_idCat);
    _getDetailCat(_idCat);
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((event) {
      currentLocation = LatLng(event.latitude, event.longitude);
      debugPrint("current lat event " + currentLocation.latitude.toString());
      debugPrint("current long event " + currentLocation.longitude.toString());
      distance = Geolocator.distanceBetween(
        //current location
        _lat,
        _long,
        //check location
        currentLocation.latitude,
        currentLocation.longitude,
      );
      debugPrint(_idCat);
      _getMap(_idCat);
      _getDetailCat(_idCat);

      if (distance <= double.parse(_radius.toString())) {
        angkacek = 1;
        setState(() {});
      } else {
        angkacek = 0;
        setState(() {});
      }
    });
    super.initState();
  }

  Future postOrder(
      id_user,
      id_catering,
      id_menu,
      nama_menu,
      harga_menu,
      tanggal_menu,
      tanggal_order,
      status_order,
      longtitude,
      langtitude,
      context) async {
    var response = await servicesCatering.inputOrder(
        id_user,
        id_catering,
        id_menu,
        nama_menu,
        harga_menu,
        tanggal_menu,
        tanggal_order,
        status_order,
        longtitude,
        langtitude);

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
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: lightText,
        child: Text(
          _idMenuList.length.toString(),
          style: GoogleFonts.inter(
              fontSize: 17, color: darkText, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 70, // to shift little up
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    width: deviceWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lightText,
                                  shape: const CircleBorder(),
                                ),
                                onPressed: () {
                                  setState(() {
                                    cek = "Harian";
                                    _dateStart = "";
                                    _dateEnd = "";
                                    Navigator.pop(context);
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: buttonColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  height: 170, // to shift little up
                  left: 25,
                  right: 25,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: buttonColor,
                          width: 1,
                          style: BorderStyle.solid),
                      color: lightText,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width: deviceWidth,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Column(
                        children: [
                          Text(
                            namaDetail,
                            style: GoogleFonts.inter(
                                fontSize: 25,
                                color: darkText,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 8),
                              Text(
                                alamatDetail,
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: darkText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.edit_document),
                              SizedBox(width: 8),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  deskripsiDetail,
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      color: darkText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: deviceWidth / 2 * 0.8,
                  height: 40,
                  child: DropdownSearch<String>(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        textAlign: TextAlign.left,
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: lightText,
                          iconColor: buttonColor,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: buttonColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: buttonColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: buttonColor,
                            ),
                          ),
                        )),
                    popupProps: const PopupProps.menu(
                      fit: FlexFit.loose,
                      showSelectedItems: false,
                      menuProps: MenuProps(
                        backgroundColor: Color(0xffE5E5E5),
                      ),
                    ),
                    items: _tipePem,
                    onChanged: (val) {
                      setState(() {
                        cek = val.toString();
                        cekDropdown = true;
                        debugPrint(cek);
                      });
                    },
                    selectedItem: "Pilih Tipe",
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: cekDropdown,
                      child: SizedBox(
                        width: deviceWidth / 2 * 0.8,
                        child: GestureDetector(
                          onTap: () {
                            selectFilterDateStart(context);
                            _dateEnd = "";
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pilih Tanggal Start",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: darkText,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 5),
                              Row(
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
                                    _dateStart,
                                    style: GoogleFonts.inter(
                                        fontSize: 17,
                                        color: darkText,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: angkacek == 1 ? true : false,
                      child: IconButton(
                        onPressed: () {
                          if (cekWarna2 == false) {
                            setState(() {
                              cekWarna = buttonColor;
                              cekWarna2 = true;
                            });
                          } else {
                            setState(() {
                              cekWarna = Colors.grey;
                              cekWarna2 = false;
                            });
                          }
                          // setState(() {
                          //   if(cekWarna2 == true){
                          //   setState(() {
                          //     cekWarna == Colors.grey;
                          //     cekWarna2 = false;
                          //   });
                          // } else{
                          //   setState(() {
                          //     cekWarna == buttonColor;
                          //     cekWarna2 = true;
                          //   });
                          // }
                          // });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: cekWarna,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: cek == "Mingguan" || cek == "Bulanan" ? true : false,
                  child: SizedBox(
                    width: deviceWidth / 2 * 0.8,
                    child: GestureDetector(
                      onTap: () {
                        selectFilterDateEnd(context, cek);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pilih Tanggal End",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                color: darkText,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                          Row(
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
                                _dateEnd,
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color: darkText,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 10,
            color: Colors.grey,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 70),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: ScrollController(),
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: FutureBuilder(
                      future: getAllMenu,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List snapData = snapshot.data! as List;
                          if (snapData[0] != 404) {
                            return ScrollConfiguration(
                              behavior:
                                  ScrollConfiguration.of(context).copyWith(
                                dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse,
                                },
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                controller: ScrollController(),
                                physics: const ClampingScrollPhysics(),
                                itemCount: snapData[1].length,
                                itemBuilder: (context, index) {
                                  debugPrint(snapData[1].length.toString());
                                  _count = List.generate(
                                      snapData[1][index]['menu'].length,
                                      (index) => 0);
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    controller: ScrollController(),
                                    physics: const ClampingScrollPhysics(),
                                    itemCount:
                                        snapData[1][index]['menu'].length,
                                    itemBuilder: (context, index2) {
                                      debugPrint(snapData[1][index]['menu']
                                          .length
                                          .toString());
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapData[1][index]['menu'][index2]
                                                    ['jam_pengiriman_awal'] +
                                                " - " +
                                                snapData[1][index]['menu']
                                                        [index2]
                                                    ['jam_pengiriman_akhir'],
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: darkText,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: buttonColor,
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  height: 100,
                                                  child: const Center(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
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
                                                SizedBox(width: 15),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    deviceWidth /
                                                                        2,
                                                                child: Text(
                                                                  snapData[1][index]
                                                                              [
                                                                              'menu']
                                                                          [
                                                                          index2]
                                                                      [
                                                                      'nama_menu'],
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          darkText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                snapData[1][index]['menu']
                                                                            [
                                                                            index2]
                                                                        [
                                                                        'harga_menu']
                                                                    .toString(),
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        18,
                                                                    color:
                                                                        darkText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Visibility(
                                                              visible:
                                                                  angkacek == 1
                                                                      ? true
                                                                      : false,
                                                              child:
                                                                  ElevatedButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      buttonColor,
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          3),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  tambah = true;
                                                                  _idMenuList.add(snapData[1][index]['menu']
                                                                              [
                                                                              index2]
                                                                          [
                                                                          'id_menu']
                                                                      .toString());
                                                                  _namaMenuList.add(snapData[1][index]['menu']
                                                                              [
                                                                              index2]
                                                                          [
                                                                          'nama_menu']
                                                                      .toString());
                                                                  _hargaMenuList.add(snapData[1][index]['menu']
                                                                              [
                                                                              index2]
                                                                          [
                                                                          'harga_menu']
                                                                      .toString());
                                                                  _tanggalMenuList.add(_dateMenu = DateFormat(
                                                                          'dd-MM-yyyy')
                                                                      .format(DateTime.parse(snapData[1][index]
                                                                              [
                                                                              'tanggal_menu']
                                                                          .toString())));
                                                                  setState(() {
                                                                    debugPrint("jancok" +
                                                                        _idMenuList
                                                                            .toString());
                                                                  });
                                                                },
                                                                child: Text(
                                                                  "Tambah",
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color:
                                                                        lightText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Visibility(
                                                            visible:
                                                                angkacek == 0
                                                                    ? true
                                                                    : false,
                                                            child: Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          3),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                  "Tambah",
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color:
                                                                        lightText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            thickness: 2,
                                            height: 20,
                                            color: buttonColor,
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        }
                        return Column();
                      },
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: angkacek == 1 ? true : false,
                  child: Expanded(
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(top: 14, bottom: 14),
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        globalLat = currentLocation.latitude.toString();
                        globalLong = currentLocation.longitude.toString();
                        alamat = await getAddressFromLatLng(
                            currentLocation.latitude,
                            currentLocation.longitude);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PembayaranPage(),
                          ),
                        );
                        // for (int i = 0; i < _idMenuList.length; i++) {
                        //   postOrder(
                        //       userID,
                        //       _idCat,
                        //       _idMenuList[i],
                        //       _namaMenuList[i],
                        //       _hargaMenuList[i],
                        //       _tanggalMenuList[i],
                        //       DateFormat('dd-MM-yyyy').format(DateTime.now()),
                        //       "0",
                        //       currentLocation.longitude,
                        //       currentLocation.latitude,
                        //       context);
                        // }
                      },
                      child: Text(
                        "Pesan",
                        style: GoogleFonts.inter(
                          color: lightText,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: angkacek == 0 ? true : false,
                  child: Expanded(
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(top: 14, bottom: 14),
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Pesan",
                        style: GoogleFonts.inter(
                          color: lightText,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  File? _selectedImage;
  final picker = ImagePicker();

  ServicesCatering servicesCat = ServicesCatering();

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      debugPrint("cokok" + _selectedImage.toString());
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future postOrder(
      id_user,
      id_catering,
      id_menu,
      nama_menu,
      harga_menu,
      tanggal_menu,
      tanggal_order,
      status_order,
      longtitude,
      langtitude,
      context) async {
    var response = await servicesCat.inputOrder(
        id_user,
        id_catering,
        id_menu,
        nama_menu,
        harga_menu,
        tanggal_menu,
        tanggal_order,
        status_order,
        longtitude,
        langtitude);

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailCateringPage(),
                ),
              ).whenComplete(() => setState(() {}));
            },
            child: Icon(Icons.arrow_back_outlined)),
        title: Text('Pembayaran'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: ScrollController(),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: ScrollController(),
                    child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          controller: ScrollController(),
                          physics: const ClampingScrollPhysics(),
                          itemCount: _idMenuList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _tanggalMenuList[index],
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: darkText,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: buttonColor,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 100,
                                        child: const Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
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
                                      SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: deviceWidth / 2,
                                                      child: Text(
                                                        _namaMenuList[index],
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 13,
                                                                color: darkText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      _hargaMenuList[index],
                                                      style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          color: darkText,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.grey,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20,
                                                          vertical: 3),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      _idMenuList
                                                          .removeAt(index);
                                                      _namaMenuList
                                                          .removeAt(index);
                                                      _hargaMenuList
                                                          .removeAt(index);
                                                      _tanggalMenuList
                                                          .removeAt(index);
                                                      setState(() {});
                                                    },
                                                    child: Text(
                                                      "Hapus",
                                                      style: GoogleFonts.inter(
                                                        color: lightText,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                  height: 20,
                                  color: buttonColor,
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alamat",
                            style: GoogleFonts.inter(
                              color: darkText,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            alamat,
                            style: GoogleFonts.inter(
                              color: darkText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Image(
                        width: 300,
                        height: 300,
                        image: AssetImage(
                          "lib/assets/images/qr.png",
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: deviceWidth / 1.2,
                            height: 350,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: _selectedImage != null
                                ? Image.file(_selectedImage!, fit: BoxFit.cover)
                                : const Center(child: Text('Bukti Pembayaran')),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _pickImage,
                            child: Text(
                              "Tambah Foto Bukti Pembayaran",
                              style: GoogleFonts.notoSans(
                                color: lightText,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(15),
                                    backgroundColor: buttonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    for (int i = 0;
                                        i < _idMenuList.length;
                                        i++) {
                                      postOrder(
                                          userID,
                                          _idCat,
                                          _idMenuList[i],
                                          _namaMenuList[i],
                                          _hargaMenuList[i],
                                          _tanggalMenuList[i],
                                          DateFormat('dd-MM-yyyy')
                                              .format(DateTime.now()),
                                          "0",
                                          globalLong,
                                          globalLat,
                                          context);
                                    }
                                  },
                                  child: Text(
                                    "Order",
                                    style: GoogleFonts.notoSans(
                                      color: lightText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
