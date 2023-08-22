import 'dart:ui';

import 'package:catering/home/drawer.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals.dart';
import '../login/services.dart';

String _nama = "";
String _telp = "";
String _email = "";
String _username = "";
String _password = "";

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String password = "aaa";
  String _tempPassword = "";
  bool _passwordVisible = true;

  ServicesUser servicesUserProfile = ServicesUser();

  final _controllerUpdate = TextEditingController();

  _ubahBintang(val) {
    for (int i = 0; i < val.length; i++) {
      _tempPassword = _tempPassword + "*";
    }
  }

  @override
  void initState() {
    _getProfile(userID).whenComplete(() => setState(() {
          _ubahBintang(_password);
        }));
    super.initState();
  }

  void _passwordVisibility() {
    if (mounted) {
      setState(() {
        _passwordVisible = !_passwordVisible;
      });
    }
  }

  Future _getProfile(id) async {
    var response = await servicesUserProfile.getProfile(id);
    if (response[0] != 404) {
      debugPrint(response[1].toString());
      _nama = response[1][0]['nama_user'].toString();
      _telp = response[1][0]['telp_user'].toString();
      _email = response[1][0]['email_user'].toString();
      _username = response[1][0]['username_user'].toString();
      _password = response[1][0]['password_user'].toString();
    } else {
      throw "Gagal Mengambil Data";
    }
  }

  Future _updateProfile(
      id_user, nama_user, telp_user, email_user, context) async {
    var response = await servicesUserProfile.updateProfileUser(
        id_user, nama_user, telp_user, email_user);
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

  _showEditNama(dw, dh, type, pw) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: ScrollController(),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Edit $type",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          height: 20,
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type,
                                  style: GoogleFonts.inter(
                                    color: buttonColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _controllerUpdate,
                                  obscureText: pw ? _passwordVisible : false,
                                  cursorColor: Colors.lightBlueAccent,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffE5E5E5),
                                    hintText: 'Input $type',
                                    hintStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
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
                                    suffixIcon: pw == true
                                        ? IconButton(
                                            color: buttonColor,
                                            onPressed: () {
                                              _passwordVisibility();
                                            },
                                            icon: Icon(_passwordVisible == true
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          )
                                        : null,
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  _controllerUpdate.clear();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.inter(
                                    color: darkText,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 50,
                                child: VerticalDivider(thickness: 1)),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  if (type == "Nama") {
                                    _updateProfile(
                                            userID,
                                            _controllerUpdate.text,
                                            _telp,
                                            _email,
                                            context)
                                        .whenComplete(() => setState(() {
                                              _getProfile(userID).whenComplete(
                                                  () => setState(() {
                                                        _ubahBintang(_password);
                                                      }));
                                            }));
                                  }
                                  if (type == "Email") {
                                    _updateProfile(userID, _nama, _telp,
                                            _controllerUpdate.text, context)
                                        .whenComplete(() => setState(() {
                                              _getProfile(userID).whenComplete(
                                                  () => setState(() {
                                                        _ubahBintang(_password);
                                                      }));
                                            }));
                                    ;
                                  }
                                  if (type == "No Telepon") {
                                    _updateProfile(
                                            userID,
                                            _nama,
                                            _controllerUpdate.text,
                                            _email,
                                            context)
                                        .whenComplete(() => setState(() {
                                              _getProfile(userID).whenComplete(
                                                  () => setState(() {
                                                        _ubahBintang(_password);
                                                      }));
                                            }));
                                    ;
                                  }
                                  _controllerUpdate.clear();
                                  Navigator.pop(context);
                                  setState(() {
                                    _getProfile(userID)
                                        .whenComplete(() => setState(() {
                                              _ubahBintang(_password);
                                            }));
                                  });
                                },
                                child: Text(
                                  "Ok",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                    color: darkText,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        _getProfile(userID);
      });
    });
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
            child: Column(
              children: [
                const SizedBox(height: 30),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('lib/assets/images/1.png'),
                ),
                const SizedBox(height: 30),
                const Divider(
                  thickness: 15,
                  color: Colors.grey,
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama",
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color: darkText,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _nama,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        color: darkText,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _showEditNama(deviceWidth, deviceHeight,
                                            "Nama", false);
                                      },
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_outlined))
                                ],
                              ),
                              const Divider(
                                thickness: 0.5,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Username",
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color: darkText,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _username,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        color: darkText,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 0.5,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color: darkText,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _email,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        color: darkText,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _showEditNama(deviceWidth, deviceHeight,
                                            "Email", false);
                                      },
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_outlined))
                                ],
                              ),
                              const Divider(
                                thickness: 0.5,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "No Telepon",
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color: darkText,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _telp,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        color: darkText,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _showEditNama(deviceWidth, deviceHeight,
                                            "No Telepon", false);
                                      },
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_outlined))
                                ],
                              ),
                              const Divider(
                                thickness: 0.5,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
