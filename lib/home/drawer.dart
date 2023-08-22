import 'dart:ui';

import 'package:catering/home/home.dart';
import 'package:catering/home/order.dart';
import 'package:catering/home/profile.dart';
import 'package:catering/home/rate.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';
import '../login/login.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {

  Future logoutAuth() async {
    setAuthPref("", 0);
  }

  // ========== Write/Read SharedPref ========== //
  Future<void> setAuthPref(String userID, int userStatus) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userID);
    await prefs.setInt('userStatus', userStatus);
  }

  Future<void> getAuthPref() async {
    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userID') ?? "";
    userStatus = prefs.getInt('userStatus') ?? 0;
  }
  // ========== Write/Read SharedPref ========== //

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
                            builder: (context) => const HomePage(),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.people_alt_outlined,
                              color: buttonColor,
                              size: 35,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              "Profile",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderPage(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.checklist_rtl_outlined,
                              color: buttonColor,
                              size: 35,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              "Order",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RatePage(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.history_outlined,
                              color: buttonColor,
                              size: 35,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              "History",
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
                      onTap: () {},
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications_active_outlined,
                              color: buttonColor,
                              size: 35,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              "Notifications",
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
                        logoutAuth().whenComplete(
                          () {
                            getAuthPref().whenComplete(() => setState((){}));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MainLoginPage(),
                              ),
                            );
                          },
                        );
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
