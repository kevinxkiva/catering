import 'dart:ui';

import 'package:catering/catering/homecatering.dart';
import 'package:catering/catering/profilecatering.dart';
import 'package:catering/home/home.dart';
import 'package:catering/home/order.dart';
import 'package:catering/home/profile.dart';
import 'package:catering/home/rate.dart';
import 'package:catering/pengantar/homepengantar.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';
import '../login/login.dart';

class DrawerPengantarPage extends StatefulWidget {
  const DrawerPengantarPage({super.key});

  @override
  State<DrawerPengantarPage> createState() => _DrawerPengantarPageState();
}

class _DrawerPengantarPageState extends State<DrawerPengantarPage> {
  Future logoutAuth() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("namaUser", "");
    pref.setString("passwordUser", "");
    pref.setBool("statusLogin", false);
    pref.setString("Id_User", "");
  }

  Future<void> getAuthPref() async {
    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userID') ?? "";
    userStatus = prefs.getInt('userStatus') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                child: Column(
                  children: const [
                    SizedBox(height: 15),
                    Center(
                      child: Image(
                        width: 250,
                        height: 250,
                        image: AssetImage(
                          "lib/assets/images/Catering Logo App.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: buttonColor,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePengantarPage(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_outlined,
                              color: buttonColor,
                              size: 35,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              "Home",
                              style: GoogleFonts.inter(
                                color: buttonColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        logoutAuth().whenComplete(() {
                          getAuthPref().whenComplete(() => setState(() {}));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MainLoginPage(),
                            ),
                          );
                        });
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: buttonColor,
                              size: 35,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              "Logout",
                              style: GoogleFonts.inter(
                                color: buttonColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
