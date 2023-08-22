import 'dart:ui';

import 'package:catering/catering/homecatering.dart';
import 'package:catering/login/services.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../globals.dart';
import '../login/login.dart';

String _idCat = "";

class BuatPengantarPage extends StatefulWidget {
  const BuatPengantarPage({super.key});

  @override
  State<BuatPengantarPage> createState() => _BuatPengantarPageState();
}

class _BuatPengantarPageState extends State<BuatPengantarPage> {
  final _controllerNamaPengantar = TextEditingController();
  final _controllerTelpPengantar = TextEditingController();
  final _controllerEmailPengantar = TextEditingController();
  final _controllerUsernamePengantar = TextEditingController();
  final _controllerPasswordPengantar = TextEditingController();

  ServicesUser servicesUser = ServicesUser();
  ServicesCatering servicesCatering = ServicesCatering();
  ServicesPengantar servicesPengantar = ServicesPengantar();

  Future postRegistPengantar(
      id_catering, nama_pengantar,
      telp_pengantar, email_pengantar, username_pengantar, password_pengantar, status_user,
      context) async {
    var response = await servicesPengantar.inputRegistPengantar(
        id_catering, nama_pengantar,
      telp_pengantar, email_pengantar, username_pengantar, password_pengantar, status_user);

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
    _getProfileCat(userID).whenComplete(() => setState(() {
        }));
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: buttonColor,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_outlined)),
        title: Text("Buat Akun Pengantar"),
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
                    "Nama Pengantar",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        letterSpacing: 0.125,
                        color: buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 3),
                TextField(
                  controller: _controllerNamaPengantar,
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
                    hintText: 'Masukkan Nama Pengantar',
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
                  controller: _controllerTelpPengantar,
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
                SizedBox(height: 15),
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
                  controller: _controllerEmailPengantar,
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
                    "Username",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        letterSpacing: 0.125,
                        color: buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 3),
                TextField(
                  controller: _controllerUsernamePengantar,
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
                    hintText: 'Masukkan Username',
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
                    "Password",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        letterSpacing: 0.125,
                        color: buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 3),
                TextField(
                  controller: _controllerPasswordPengantar,
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
                    hintText: 'Masukkan Password',
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
                          postRegistPengantar(_idCat, _controllerNamaPengantar.text, _controllerTelpPengantar.text, _controllerEmailPengantar.text, _controllerUsernamePengantar.text, _controllerPasswordPengantar.text, "3", context).then((value) => Navigator.of(context)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomeCateringPage()),
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
