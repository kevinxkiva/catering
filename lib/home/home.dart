import 'dart:ui';

import 'package:catering/home/buatcatering.dart';
import 'package:catering/home/drawer.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'detailcatering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controllerCoro = CarouselController();
  int _current = 0;

  List<String> imageCaro = [
    "lib/assets/images/1.png",
    "lib/assets/images/2.jpg",
  ];

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
                              builder: (context) => const ListCateringPage(type: 'Semua',),
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
                                "Semua",
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
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListCateringPage(type: 'Rating',),
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
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListCateringPage(type: 'Favorite',),
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
                                  height: 80,
                                  image: AssetImage(
                                    "lib/assets/images/fav.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Favorit",
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
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListCateringPage(type: 'Harian',),
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
                                    "lib/assets/images/day.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Harian",
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
                              builder: (context) => const ListCateringPage(type: 'Mingguan',),
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
                                  height: 70,
                                  image: AssetImage(
                                    "lib/assets/images/week.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Mingguan",
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
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListCateringPage(type: 'Bulanan',),
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
                                  height: 70,
                                  image: AssetImage(
                                    "lib/assets/images/month.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Bulanan",
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
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: lightText,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: lightText,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: imageCaro.asMap().entries.map((entry) {
                    return Container(
                      width: 12,
                      height: 12,
                      margin: EdgeInsets.fromLTRB(4, 25, 4, 5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? lightText
                                  : buttonColor)
                              .withOpacity(_current == entry.key ? 1 : 0.4)),
                    );
                  }).toList(),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: lightText,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: deviceWidth,
                    height: 170,
                    child: CarouselSlider(
                      carouselController: _controllerCoro,
                      items: imageCaro
                          .map(
                            (image) => ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Image.asset(
                                image,
                                width: deviceWidth,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          initialPage: 0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rating Pesenan Sebelumnya Yuk...",
                      style: GoogleFonts.inter(
                          fontSize: 17,
                          color: buttonColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: deviceWidth,
                  //height: 250,
                  child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: buttonColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Catering A",
                              style: GoogleFonts.inter(
                                  fontSize: 17,
                                  color: darkText,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "13-11-2022",
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: darkText,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Ayam geprek + nasi + sayur sop",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: darkText,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "26.000",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: darkText,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 150,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: const Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "lib/assets/images/geprek.jpg",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
