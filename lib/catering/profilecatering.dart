import 'dart:ui';

import 'package:catering/catering/drawercatering.dart';
import 'package:catering/home/drawer.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals.dart';
import '../login/services.dart';

String _nama = "";
String _telp = "";
String _email = "";
String _deskripsi = "";
String _password = "";
String _alamat = "";
List _type =[];

String _idCat = "";

class EditProfileCatering extends StatefulWidget {
  const EditProfileCatering({super.key});

  @override
  State<EditProfileCatering> createState() => _EditProfileCateringState();
}

class _EditProfileCateringState extends State<EditProfileCatering> {
  String password = "aaa";
  String _tempPassword = "";
  bool _passwordVisible = true;

  ServicesUser servicesUserProfile = ServicesUser();
  ServicesCatering servicesUserProfileCat = ServicesCatering();

  final _controllerUpdate = TextEditingController();

  _ubahBintang(val) {
    for (int i = 0; i < val.length; i++) {
      _tempPassword = _tempPassword + "*";
    }
  }

  @override
  void initState() {
    _getProfileCat(userID).whenComplete(() => setState(() {
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

  Future _getProfileCat(id) async {
    var response = await servicesUserProfileCat.getProfileCatering(id);
    debugPrint(response[0].toString());
    if (response[0] != 404) {
      debugPrint(response[1].toString());
      _idCat = response[1][0]['id_catering'].toString();
      _nama = response[1][0]['nama_catering'].toString();
      _telp = response[1][0]['telp_catering'].toString();
      _email = response[1][0]['email_catering'].toString();
      _deskripsi = response[1][0]['deskripsi_catering'].toString();
      _alamat = response[1][0]['alamat_catering'].toString();
      _type = response[1][0]['tipe_pemesanan'];
      debugPrint(_type.toString());
    } else {
      throw "Gagal Mengambil Data";
    }
  }

  Future _updateProfileCat(id_catering, nama_catering, alamat_catering, telp_catering, email_catering, deskripsi_catering, context) async {
    var response = await servicesUserProfileCat.updateProfileCatering(
        id_catering, nama_catering, alamat_catering, telp_catering, email_catering, deskripsi_catering);
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
                                    _updateProfileCat(
                                      _idCat, _controllerUpdate.text, _alamat, _telp, _email, _deskripsi, context
                                    )
                                        .whenComplete(() => setState(() {
                                              _getProfileCat(userID).whenComplete(
                                                  () => setState(() {
                                                      }));
                                            }));
                                  }
                                  if (type == "Alamat") {
                                    _updateProfileCat(
                                      _idCat, _nama, _controllerUpdate.text, _telp, _email, _deskripsi, context
                                    )
                                        .whenComplete(() => setState(() {
                                              _getProfileCat(userID).whenComplete(
                                                  () => setState(() {
                                                      }));
                                            }));
                                    ;
                                  }
                                  if (type == "Email") {
                                    _updateProfileCat(
                                      _idCat, _nama, _alamat, _telp, _controllerUpdate.text, _deskripsi, context
                                    )
                                        .whenComplete(() => setState(() {
                                              _getProfileCat(userID).whenComplete(
                                                  () => setState(() {
                                                      }));
                                            }));
                                    ;
                                  }
                                  if (type == "No Telepon") {
                                    _updateProfileCat(
                                      _idCat, _nama, _alamat, _controllerUpdate.text, _email, _deskripsi, context
                                    )
                                        .whenComplete(() => setState(() {
                                              _getProfileCat(userID).whenComplete(
                                                  () => setState(() {
                                                      }));
                                            }));
                                    ;
                                  }
                                  if (type == "Deskripsi") {
                                    _updateProfileCat(
                                      _idCat, _nama, _alamat, _telp, _email, _controllerUpdate.text, context
                                    )
                                        .whenComplete(() => setState(() {
                                              _getProfileCat(userID).whenComplete(
                                                  () => setState(() {
                                                      }));
                                            }));
                                    ;
                                  }
                                  _controllerUpdate.clear();
                                  Navigator.pop(context);
                                  setState(() {
                                    _getProfileCat(userID)
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
        _getProfileCat(userID);
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
          child: DrawerCateringPage(),
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
                                "Alamat",
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
                                    _alamat,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        color: darkText,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _showEditNama(deviceWidth, deviceHeight,
                                            "Alamat", false);
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
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Deskripsi",
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
                                    _deskripsi,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        color: darkText,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _showEditNama(deviceWidth, deviceHeight,
                                            "Deskripsi", false);
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
                                "Tipe Pemesanan",
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
                                    _type[0] + ", " + _type[1],
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
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
