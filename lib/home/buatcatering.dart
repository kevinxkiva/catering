import 'dart:ui';


import 'package:catering/login/services.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../login/login.dart';

class BuatCateringPage extends StatefulWidget {
  final String myUsername;
  final String myPassword;
  const BuatCateringPage(
      {Key? key, required this.myUsername, required this.myPassword})
      : super(key: key);

  @override
  State<BuatCateringPage> createState() => _BuatCateringPageState();
}

class _BuatCateringPageState extends State<BuatCateringPage> {
  String _id = "";
  Future postRegistCatering(
      id_user,
      nama_catering,
      alamat_catering,
      telp_catering,
      email_catering,
      deskripsi_catering,
      tipe_pemesanan,
      context) async {
    var response = await servicesCateringRegist.inputRegistCatering(
        id_user,
        nama_catering,
        alamat_catering,
        telp_catering,
        email_catering,
        deskripsi_catering,
        tipe_pemesanan);

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

  final List _roleList = [
    ['Harian', false],
    ['Mingguan', false],
    ['Bulanan', false],
  ];

  String roleSeparator = "";

  void stringSeparator() {
    for (var element in _roleList) {
      if (element[1] == true) {
        roleSeparator += "|${element[0]}|";
      }
    }
    debugPrint(roleSeparator);
  }

  final List _tempRole = [0, 0, 0];

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return buttonColorabu;
  }

  bool _passwordVisible = false;

  final _controllerNamaCatering = TextEditingController();
  final _controllerAlamatCatering = TextEditingController();
  final _controllerTelpCatering = TextEditingController();
  final _controllerEmailCatering = TextEditingController();
  final _controllerDeskripsiCatering = TextEditingController();

  ServicesUser servicesUserLogin = ServicesUser();
  ServicesCatering servicesCateringRegist = ServicesCatering();

  @override
  void initState() {
    // TODO: implement initState
    _getId().whenComplete(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future _getId() async {
    var response =
        await servicesUserLogin.getLogin(widget.myUsername, widget.myPassword);
    if (response[0] != 404) {
      _id = response[1]['id_user'].toString();
      debugPrint(_id);
    } else {
      throw "Gagal Mengambil Data";
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
        title: Text(_id),
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
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nama Catering",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        letterSpacing: 0.125,
                        color: buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 3),
                TextField(
                  controller: _controllerNamaCatering,
                  readOnly: false,
                  showCursor: true,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Masukkan Nama Catering',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 12,
                        letterSpacing: 0.125,
                        color: darkText,
                        fontWeight: FontWeight.w300),
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
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Alamat Catering",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        letterSpacing: 0.125,
                        color: buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 3),
                TextField(
                  controller: _controllerAlamatCatering,
                  readOnly: false,
                  showCursor: true,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Masukkan Alamat Catering',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 12,
                        letterSpacing: 0.125,
                        color: darkText,
                        fontWeight: FontWeight.w300),
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
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "No Telepon",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        letterSpacing: 0.125,
                        color: buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 3),
                TextField(
                  controller: _controllerTelpCatering,
                  keyboardType: TextInputType.phone,
                  readOnly: false,
                  showCursor: true,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Masukkan No Telepon',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 12,
                        letterSpacing: 0.125,
                        color: darkText,
                        fontWeight: FontWeight.w300),
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
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        letterSpacing: 0.125,
                        color: buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 3),
                TextField(
                  controller: _controllerEmailCatering,
                  readOnly: false,
                  showCursor: true,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Masukkan Email',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 12,
                        letterSpacing: 0.125,
                        color: darkText,
                        fontWeight: FontWeight.w300),
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
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Deskripsi",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        letterSpacing: 0.125,
                        color: buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 3),
                TextField(
                  controller: _controllerDeskripsiCatering,
                  maxLines: 4,
                  readOnly: false,
                  showCursor: true,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Masukkan Deskripsi',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 12,
                        letterSpacing: 0.125,
                        color: darkText,
                        fontWeight: FontWeight.w300),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
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
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Waktu Pemesanan",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        letterSpacing: 0.125,
                        color: buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  physics: const ClampingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      checkColor: buttonColor,
                      contentPadding: const EdgeInsets.all(0),
                      title: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: buttonColor.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Text(
                            _roleList[index][0],
                          ),
                        ),
                      ),
                      value: _roleList[index][1],
                      onChanged: (e) {
                        _roleList[index][1] = e;
                        setState(() {});
                        if (e == true) {
                          _tempRole[index] = index + 1;
                        } else {
                          _tempRole[index] = 0;
                        }
                        debugPrint(_tempRole.toString());
                      },
                    );
                  },
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
                          stringSeparator();
                          postRegistCatering(
                              _id,
                              _controllerNamaCatering.text,
                              _controllerAlamatCatering.text,
                              _controllerTelpCatering.text,
                              _controllerEmailCatering.text,
                              _controllerDeskripsiCatering.text,
                              roleSeparator,
                              context).then((value) => Navigator.of(context)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MainLoginPage()),
                                  (Route<dynamic> route) => false));
                        },
                        child: Text(
                          "Register",
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
