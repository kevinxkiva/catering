import 'dart:ui';

import 'package:catering/home/buatcatering.dart';
import 'package:catering/login/login.dart';
import 'package:catering/login/loginmain.dart';
import 'package:catering/login/nextregist.dart';
import 'package:catering/login/services.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

String namaKirim = "";
String passKirim = "";

class RegisterMain extends StatefulWidget {
  const RegisterMain({super.key});

  @override
  State<RegisterMain> createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController2;
  bool _passwordVisible = false;
  ServicesUser servicesUser = ServicesUser();

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

  final _controllerNamaUser = TextEditingController();
  final _controllerUsernameUser = TextEditingController();
  final _controllerTelpUser = TextEditingController();
  final _controllerPasswordUser = TextEditingController();
  final _controllerEmailUser = TextEditingController();

  @override
  void initState() {
    _tabController2 = TabController(length: 2, vsync: this);
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _tabController2.dispose();
    super.dispose();
  }

  Future postRegistUser(nama_user, telp_user, email_user, usernmae_user,
      password_user, status_user, context) async {
    var response = await servicesUser.inputRegistUser(
      nama_user,
      telp_user,
      email_user,
      usernmae_user,
      password_user,
      status_user,
    );

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
  bool get wantKeepAlive => true;

  _passwordLogin(pw, controllers) {
    return TextField(
      controller: controllers,
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
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nama User",
                style: GoogleFonts.nunito(
                    fontSize: 18,
                    letterSpacing: 0.125,
                    color: buttonColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 3),
            TextField(
              controller: _controllerNamaUser,
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
                hintText: 'Masukkan Nama User',
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
              controller: _controllerEmailUser,
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
              controller: _controllerUsernameUser,
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
              controller: _controllerTelpUser,
              readOnly: false,
              showCursor: true,
              keyboardType: TextInputType.phone,
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
                "Password",
                style: GoogleFonts.nunito(
                    fontSize: 18,
                    letterSpacing: 0.125,
                    color: buttonColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 3),
            _passwordLogin(false, _controllerPasswordUser),
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
                      postRegistUser(
                              _controllerNamaUser.text,
                              _controllerTelpUser.text,
                              _controllerEmailUser.text,
                              _controllerUsernameUser.text,
                              _controllerPasswordUser.text,
                              1,
                              context)
                          .then((value) => Navigator.of(context)
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
                      namaKirim = _controllerUsernameUser.text;
                      passKirim = _controllerPasswordUser.text;
                      postRegistUser(
                              _controllerNamaUser.text,
                              _controllerTelpUser.text,
                              _controllerEmailUser.text,
                              _controllerUsernameUser.text,
                              _controllerPasswordUser.text,
                              2,
                              context)
                          .then((value) => Navigator.of(context)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => BuatCateringPage(
                                          myUsername: namaKirim,
                                          myPassword: passKirim)),
                                  (Route<dynamic> route) => false));
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
    );
  }
}
