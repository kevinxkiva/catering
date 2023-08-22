import 'dart:ui';

import 'package:catering/catering/homecatering.dart';
import 'package:catering/home/home.dart';
import 'package:catering/login/services.dart';
import 'package:catering/pengantar/homepengantar.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../globals.dart';

String? usernameA = "";
String? passwordA = "";
String? status;
String? Id;
final userkeyl = GlobalKey<FormState>();
final passkeyl = GlobalKey<FormState>();
bool strok = false;
bool hidePass = true;
final TextEditingController controllerUsername = TextEditingController();
final TextEditingController controllerPassword = TextEditingController();
String usernameSP = "";
String passwordSP = "";
bool statusSP = false;
int IdSP = 0;

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  bool _passwordVisible = false;
  var berhasiLogin = false;
  final pref = SharedPreferences.getInstance();

  void _passwordVisibility() {
    if (mounted) {
      setState(() {
        _passwordVisible = !_passwordVisible;
      });
    }
  }

  ServicesUser servicesUser = ServicesUser();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
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

  Login(context, username, password) async {
    var response = await servicesUser.getLogin(username, password);
    if (response[0] == 200) {
      setAuthPref(
        response[1]['id_user'],
        response[1]['status_user'],
      );
      if (response[1]['status_user'] == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
      } else if (response[1]['status_user'] == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomeCateringPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePengantarPage(),
          ),
        );
      }
    }
  }

  void clear() {
    controllerUsername.clear();
    controllerPassword.clear();
  }

  _passwordLogin(pw) {
    return TextField(
      readOnly: false,
      showCursor: true,
      obscureText: !_passwordVisible,
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
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: buttonColorabu,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        controller: ScrollController(),
        child: Column(
          children: [
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
            Form(
              key: GlobalKey<FormState>(),
              child: Form(
                key: userkeyl,
                child: TextFormField(
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      strok = true;
                      return 'Username Kosong';
                    } else if (berhasiLogin == false) {
                      strok = true;
                      return 'Username Salah';
                    }
                    return null;
                  },
                  cursorColor: Colors.black,
                  controller: controllerUsername,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    hintText: 'Masukkan Username',
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
              ),
            ),
            const SizedBox(height: 15),
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
            //_passwordLogin(false),
            Form(
              key: GlobalKey<FormState>(),
              child: TextFormField(
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    strok = true;
                    return 'Password Kosong';
                  } else if (berhasiLogin == false) {
                    strok = true;
                    return 'Password Salah';
                  }
                  return null;
                },
                controller: controllerPassword,
                obscureText: hidePass,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffE5E5E5),
                  hintText: 'Masukkan Password',
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
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePass = !hidePass;
                      });
                    },
                    icon: hidePass == false
                        ? const Icon(Icons.remove_red_eye_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(top: 14, bottom: 14),
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      Login(context, controllerUsername.text,
                              controllerPassword.text)
                          .whenComplete(() {
                        getAuthPref().whenComplete(() => setState(() {}));
                        setState(() {
                          controllerUsername.clear();
                          controllerPassword.clear();
                        });
                      });
                    },
                    child: Text(
                      "Login",
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
    );
  }
}
