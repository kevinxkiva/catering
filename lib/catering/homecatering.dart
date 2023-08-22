import 'dart:ui';

import 'package:catering/catering/buatmenu.dart';
import 'package:catering/catering/budgeting.dart';
import 'package:catering/catering/drawercatering.dart';
import 'package:catering/catering/setlokasi.dart';
import 'package:catering/home/drawer.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'buatpengantar.dart';

class HomeCateringPage extends StatefulWidget {
  const HomeCateringPage({super.key});

  @override
  State<HomeCateringPage> createState() => _HomeCateringPageState();
}

class _HomeCateringPageState extends State<HomeCateringPage> {
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
        child: DrawerCateringPage(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BuatMenuPage(),
                            ),
                          );
                        },
                        child: Column(
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
                              child: Center(
                                child: Image(
                                  height: 70,
                                  image: AssetImage(
                                    "lib/assets/images/all.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Menu",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: buttonColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SetLokasiPage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: buttonColor,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image(
                                  height: 50,
                                  width: 90,
                                  image: AssetImage(
                                    "lib/assets/images/rate.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Set Lokasi",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: buttonColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BudgetingPage(),
                            ),
                          );
                        },
                        child: Column(
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
                              child: Center(
                                child: Image(
                                  height: 70,
                                  image: AssetImage(
                                    "lib/assets/images/all.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Budgeting",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: buttonColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: buttonColor,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image(
                                  height: 50,
                                  width: 90,
                                  image: AssetImage(
                                    "lib/assets/images/rate.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Rating",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: buttonColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Column(
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
                              child: Center(
                                child: Image(
                                  height: 70,
                                  image: AssetImage(
                                    "lib/assets/images/all.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Order",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: buttonColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BuatPengantarPage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: buttonColor,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image(
                                  height: 50,
                                  width: 90,
                                  image: AssetImage(
                                    "lib/assets/images/rate.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Tambah Pengantar",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: buttonColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
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
