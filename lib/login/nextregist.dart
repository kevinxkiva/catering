import 'dart:ui';

import 'package:catering/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';

class NextRegistCatering extends StatefulWidget {
  const NextRegistCatering({super.key});

  @override
  State<NextRegistCatering> createState() => _NextRegistCateringState();
}

class _NextRegistCateringState extends State<NextRegistCatering> {
  // static String sun = "Harian";
  // static String mon = "Mingguan";
  // static String tue = "Bulanan";

  Map<String, bool> days = {
    "Harian": false,
    "Mingguan": false,
    "Bulanan": false,
  };

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

  Widget checkbox(String title, bool boolValue) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          checkColor: lightText,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: boolValue,
          onChanged: (value) => setState(() => days[title] = value!),
        ),
        Text(title),
        const SizedBox(width: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: lightText,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: ScrollController(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
              child: Column(
                children: [
                  const Center(
                    child: Image(
                      width: 250,
                      height: 250,
                      image: AssetImage(
                        "lib/assets/images/Catering Logo App.png",
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
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
                      "Alamat",
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          letterSpacing: 0.125,
                          color: buttonColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 3),
                  TextField(
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
                      hintText: 'Masukkan Alamat',
                      hintStyle: GoogleFonts.nunito(
                          fontSize: 12,
                          letterSpacing: 0.125,
                          color: darkText,
                          fontWeight: FontWeight.w300),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
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
                  Row(
                    children: <Widget>[
                      checkbox('Harian', days['Harian']!),
                      checkbox('Mingguan', days['Mingguan']!),
                      checkbox('Bulanan', days['Bulanan']!),
                    ],
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const HomePage(),
                                ),
                              );
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
                  SizedBox(height: 15),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const HomePage(),
                                ),
                              );
                          },
                          child: Text(
                            "Lanjut Regist Catering",
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
      ),
    );
  }
}
