import 'dart:io';

import 'package:catering/catering/homecatering.dart';
import 'package:catering/globals.dart';
import 'package:catering/login/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

DateTime _selectedDate2 = DateTime.now();
String _formattedDate2 = "";
String _date2 = "";

String _idCat = "";
String _idMenu = "";

class BuatMenuPage extends StatefulWidget {
  const BuatMenuPage({super.key});

  @override
  State<BuatMenuPage> createState() => _BuatMenuPageState();
}

class _BuatMenuPageState extends State<BuatMenuPage> {
  final _controllerNamaMenu = TextEditingController();
  final _controllerTotalPorsiMenu = TextEditingController();

  late Future getAllMenu;
  ServicesCatering servicesCat = ServicesCatering();

  @override
  void initState() {
    // TODO: implement initState
    _date2 = DateFormat('dd-MM-yyyy').format(_selectedDate2);
    _getProfileCat(userID).whenComplete(() => setState(() {}));
    getAllMenu = servicesCat.getMenuCatering(_idCat, _date2);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future _getProfileCat(id) async {
    var response = await servicesCat.getProfileCatering(id);
    debugPrint(response[0].toString());
    if (response[0] != 404) {
      debugPrint(response[1].toString());
      _idCat = response[1][0]['id_catering'].toString();
    } else {
      throw "Gagal Mengambil Data";
    }
  }

  TextFieldYa(controllers, color) {
    return TextField(
      readOnly: false,
      controller: controllers,
      showCursor: true,
      cursorColor: darkText,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 13,
      ),
      onChanged: (value) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: color,
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: darkText,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkText, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkText, width: 0.5),
        ),
      ),
    );
  }

  Future<void> selectFilterDate2(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate2,
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
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
    if (picked != null && picked != _selectedDate2) {
      if (mounted) {
        _selectedDate2 = picked;
        _formattedDate2 = DateFormat('dd-MM-yyyy').format(_selectedDate2);
        _date2 = _formattedDate2;

        setState(() {});
      }
    }
  }

  File? _selectedImage;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    setState(() {});
  }

  Future deleteMenu(id_catering, id_menu, tanggal_menu, context) async {
    var response =
        await servicesCat.deleteMenu(id_catering, id_menu, tanggal_menu);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahMenuPage(),
            ),
          );
        },
        backgroundColor: buttonColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: buttonColor,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeCateringPage(),
                ),
              ).whenComplete(() => setState(() {}));
            },
            child: Icon(Icons.arrow_back_outlined)),
        title: Text('Menu'),
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
                  padding: const EdgeInsets.fromLTRB(15, 26, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectFilterDate2(context);
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
                              _date2,
                              style: GoogleFonts.inter(
                                  fontSize: 17,
                                  color: darkText,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          getAllMenu =
                              servicesCat.getMenuCatering(_idCat, _date2);
                          setState(() {});
                        },
                        child: Text(
                          "Cari",
                          style: GoogleFonts.inter(
                            color: lightText,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
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
                Padding(
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
                                                snapData[1][index]['menu']
                                                            [index2][
                                                        'jam_pengiriman_awal'] +
                                                    " - " +
                                                    snapData[1][index]['menu']
                                                            [index2][
                                                        'jam_pengiriman_akhir'],
                                                style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    color: darkText,
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                                            style: BorderStyle
                                                                .solid),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                          SizedBox(
                                                            width:
                                                                deviceWidth / 2,
                                                            child: Text(
                                                              snapData[1][index]
                                                                          [
                                                                          'menu']
                                                                      [index2]
                                                                  ['nama_menu'],
                                                              style: GoogleFonts.inter(
                                                                  fontSize: 13,
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
                                                            snapData[1][index][
                                                                            'menu']
                                                                        [index2]
                                                                    [
                                                                    'harga_menu']
                                                                .toString(),
                                                            style: GoogleFonts.inter(
                                                                fontSize: 18,
                                                                color: darkText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
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
                                                                child:
                                                                    ElevatedButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        buttonColor,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            15,
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
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                EditGambarMenuPage(),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    "+ Gambar",
                                                                    style: GoogleFonts
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
                                                              SizedBox(
                                                                  width: 10),
                                                              Expanded(
                                                                child:
                                                                    ElevatedButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        buttonColor,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            15,
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
                                                                      () {
                                                                        _idMenu = snapData[1][index]['menu'][index2]['id_menu']
                                                                                .toString();
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                EditMenuPage(),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    "Edit Menu",
                                                                    style: GoogleFonts
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
                                                              SizedBox(
                                                                  width: 10),
                                                              Expanded(
                                                                child:
                                                                    ElevatedButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        buttonColor,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            15,
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
                                                                      () {
                                                                    deleteMenu(
                                                                            snapData[1][index]['id_catering']
                                                                                .toString(),
                                                                            snapData[1][index]['menu'][index2]['id_menu']
                                                                                .toString(),
                                                                            _date2,
                                                                            context)
                                                                        .whenComplete(
                                                                            () {
                                                                      setState(
                                                                          () {
                                                                            getAllMenu = servicesCat.getMenuCatering(_idCat, _date2);
                                                                          });
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                    "Delete",
                                                                    style: GoogleFonts
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TambahMenuPage extends StatefulWidget {
  const TambahMenuPage({super.key});

  @override
  State<TambahMenuPage> createState() => _TambahMenuPageState();
}

class _TambahMenuPageState extends State<TambahMenuPage> {
  final _controllerNamaMenuTambah = TextEditingController();
  final _controllerHargaMenuTambah = TextEditingController();

  ServicesCatering servicesCatering = ServicesCatering();

  Future postMenu(id_catering, nama_menu, harga_menu, tanggal_menu,
      jam_pengiriman_awal, jam_pengiriman_akhir, status, context) async {
    var response = await servicesCatering.inputMenuCatering(
        id_catering,
        nama_menu,
        harga_menu,
        tanggal_menu,
        jam_pengiriman_awal,
        jam_pengiriman_akhir,
        status);

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

  TextFieldYa(controllers, color) {
    return TextField(
      readOnly: false,
      controller: controllers,
      showCursor: true,
      cursorColor: darkText,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 13,
      ),
      onChanged: (value) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: color,
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: darkText,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkText, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkText, width: 0.5),
        ),
      ),
    );
  }

  File? _selectedImage;
  final picker = ImagePicker();

  TimeOfDay _time = TimeOfDay(hour: 0, minute: 0);
  String formattedTime = "00:00";

  TimeOfDay _time2 = TimeOfDay(hour: 0, minute: 0);
  String formattedTime2 = "00:00";

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    setState(() {});
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
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
    if (newTime != null) {
      setState(() {
        _time = newTime;
        formattedTime =
            '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _selectTime2() async {
    final TimeOfDay? newTime2 = await showTimePicker(
      context: context,
      initialTime: _time2,
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
    if (newTime2 != null) {
      setState(() {
        _time2 = newTime2;
        formattedTime2 =
            '${newTime2.hour.toString().padLeft(2, '0')}:${newTime2.minute.toString().padLeft(2, '0')}';
      });
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
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_outlined)),
        title: Text('Tambah Menu'),
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
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _date2,
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Nama Menu",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _controllerNamaMenuTambah,
                  readOnly: false,
                  cursorColor: Colors.lightBlueAccent,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Input Nama Menu',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Harga Menu",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  readOnly: false,
                  controller: _controllerHargaMenuTambah,
                  cursorColor: Colors.lightBlueAccent,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Input Harga Menu',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Perkiraan Waktu Kirim",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Start",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _selectTime,
                  child: Text(
                    formattedTime,
                    style: GoogleFonts.notoSans(
                      color: lightText,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "End",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _selectTime2,
                  child: Text(
                    formattedTime2,
                    style: GoogleFonts.notoSans(
                      color: lightText,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(top: 14, bottom: 14),
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          postMenu(
                                  _idCat,
                                  _controllerNamaMenuTambah.text,
                                  _controllerHargaMenuTambah.text,
                                  _date2,
                                  formattedTime,
                                  formattedTime2,
                                  "0",
                                  context)
                              .then((value) => Navigator.of(context)
                                  .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => BuatMenuPage()),
                                      (Route<dynamic> route) => false));
                        },
                        child: Text(
                          "Simpan",
                          style: GoogleFonts.inter(
                            color: lightText,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditMenuPage extends StatefulWidget {
  const EditMenuPage({super.key});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  late Future getAllMenu;
  ServicesCatering servicesCat = ServicesCatering();

  TextFieldYa(controllers, color) {
    return TextField(
      readOnly: false,
      controller: controllers,
      showCursor: true,
      cursorColor: darkText,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 13,
      ),
      onChanged: (value) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: color,
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: darkText,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkText, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkText, width: 0.5),
        ),
      ),
    );
  }

  File? _selectedImage;
  final picker = ImagePicker();

  TimeOfDay _time = TimeOfDay(hour: 0, minute: 0);
  String formattedTime = "00:00";

  TimeOfDay _time2 = TimeOfDay(hour: 0, minute: 0);
  String formattedTime2 = "00:00";

  final _controllerNamaMenuTambahEdit = TextEditingController();
  final _controllerHargaMenuTambahEdit = TextEditingController();

  Future _updateMenu(id_catering, id_menu, nama_menu, harga_menu, tanggal_menu, jam_pengiriman_awal, jam_pengiriman_akhir, context) async {
    var response = await servicesCat.updateMenu(
        id_catering, id_menu, nama_menu, harga_menu, tanggal_menu, jam_pengiriman_awal, jam_pengiriman_akhir);
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

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
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
    if (newTime != null) {
      setState(() {
        _time = newTime;
        formattedTime =
            '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _selectTime2() async {
    final TimeOfDay? newTime2 = await showTimePicker(
      context: context,
      initialTime: _time2,
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
    if (newTime2 != null) {
      setState(() {
        _time2 = newTime2;
        formattedTime2 =
            '${newTime2.hour.toString().padLeft(2, '0')}:${newTime2.minute.toString().padLeft(2, '0')}';
      });
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
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_outlined)),
        title: Text('Edit Menu'),
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
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _date2,
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                // Text(
                //   "Gambar Menu",
                //   style: GoogleFonts.inter(
                //     color: darkText,
                //     fontWeight: FontWeight.w800,
                //     fontSize: 15,
                //   ),
                // ),
                // const SizedBox(height: 5),
                // Column(
                //   children: [
                //     Container(
                //       width: deviceWidth,
                //       height: 350,
                //       decoration: BoxDecoration(
                //         border: Border.all(),
                //       ),
                //       child: _selectedImage != null
                //           ? Image.file(_selectedImage!, fit: BoxFit.cover)
                //           : const Center(child: Text('No image selected')),
                //     ),
                //     const SizedBox(height: 20),
                //     ElevatedButton(
                //       style: TextButton.styleFrom(
                //         padding: const EdgeInsets.all(15),
                //         backgroundColor: buttonColor,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //       ),
                //       onPressed: _pickImage,
                //       child: Text(
                //         "Tambah Gambar",
                //         style: GoogleFonts.notoSans(
                //           color: lightText,
                //           fontWeight: FontWeight.w600,
                //           fontSize: 15,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 15),
                Text(
                  "Nama Menu",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _controllerNamaMenuTambahEdit,
                  readOnly: false,
                  cursorColor: Colors.lightBlueAccent,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Input Nama Menu',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Harga Menu",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _controllerHargaMenuTambahEdit,
                  readOnly: false,
                  cursorColor: Colors.lightBlueAccent,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Input Harga Menu',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Perkiraan Waktu Kirim",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Start",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _selectTime,
                  child: Text(
                    formattedTime,
                    style: GoogleFonts.notoSans(
                      color: lightText,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "End",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _selectTime2,
                  child: Text(
                    formattedTime2,
                    style: GoogleFonts.notoSans(
                      color: lightText,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(top: 14, bottom: 14),
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          _updateMenu(_idCat, _idMenu, _controllerNamaMenuTambahEdit.text, _controllerHargaMenuTambahEdit.text, _date2, formattedTime, formattedTime2, context);
                          Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BuatMenuPage(),
                                      ),
                                    ).whenComplete(() => setState(() {}));
                        },
                        child: Text(
                          "Simpan",
                          style: GoogleFonts.inter(
                            color: lightText,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditGambarMenuPage extends StatefulWidget {
  const EditGambarMenuPage({super.key});

  @override
  State<EditGambarMenuPage> createState() => _EditGambarMenuPageState();
}

class _EditGambarMenuPageState extends State<EditGambarMenuPage> {

  TextFieldYa(controllers, color) {
    return TextField(
      readOnly: false,
      controller: controllers,
      showCursor: true,
      cursorColor: darkText,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 13,
      ),
      onChanged: (value) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: color,
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: darkText,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkText, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkText, width: 0.5),
        ),
      ),
    );
  }

  File? _selectedImage;
  final picker = ImagePicker();

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
        title: Text('Edit Gambar Menu'),
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
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  "Gambar Menu",
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Column(
                  children: [
                    Container(
                      width: deviceWidth,
                      height: 350,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: _selectedImage != null
                          ? Image.file(_selectedImage!, fit: BoxFit.cover)
                          : const Center(child: Text('No image selected')),
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
                        "Tambah Gambar",
                        style: GoogleFonts.notoSans(
                          color: lightText,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(top: 14, bottom: 14),
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Simpan",
                          style: GoogleFonts.inter(
                            color: lightText,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
