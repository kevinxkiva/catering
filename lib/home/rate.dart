import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';
import 'drawer.dart';

import 'package:intl/intl.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  DateTime _selectedDate = DateTime.now();
  String _formattedDate = "";
  String _date = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();

  List<Color> warnaBintang = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  Future<void> selectFilterDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 10, 12, 31),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: buttonColor, // header background color
                onPrimary: lightText, // header text color
                onSurface: darkText, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: buttonColor, // button text color
                ),
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != _selectedDate) {
      if (mounted) {
        _selectedDate = picked;
        _formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
        _date = _formattedDate;

        setState(() {});
      }
    }
  }

  _showPenilaian(dw, dh) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
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
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Penilaian",
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
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rating",
                                  style: GoogleFonts.inter(
                                    color: darkText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: warnaBintang[0],
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          warnaBintang[0] = buttonColor;
                                          warnaBintang[1] = Colors.grey;
                                          warnaBintang[2] = Colors.grey;
                                          warnaBintang[3] = Colors.grey;
                                          warnaBintang[4] = Colors.grey;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: warnaBintang[1],
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          warnaBintang[0] = buttonColor;
                                          warnaBintang[1] = buttonColor;
                                          warnaBintang[2] = Colors.grey;
                                          warnaBintang[3] = Colors.grey;
                                          warnaBintang[4] = Colors.grey;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: warnaBintang[2],
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          warnaBintang[0] = buttonColor;
                                          warnaBintang[1] = buttonColor;
                                          warnaBintang[2] = buttonColor;
                                          warnaBintang[3] = Colors.grey;
                                          warnaBintang[4] = Colors.grey;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: warnaBintang[3],
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          warnaBintang[0] = buttonColor;
                                          warnaBintang[1] = buttonColor;
                                          warnaBintang[2] = buttonColor;
                                          warnaBintang[3] = buttonColor;
                                          warnaBintang[4] = Colors.grey;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: warnaBintang[4],
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          warnaBintang[0] = buttonColor;
                                          warnaBintang[1] = buttonColor;
                                          warnaBintang[2] = buttonColor;
                                          warnaBintang[3] = buttonColor;
                                          warnaBintang[4] = buttonColor;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Review",
                                  style: GoogleFonts.inter(
                                    color: darkText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 5),
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
                                    hintText: 'Input Review',
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
                              ],
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Divider(
                          height: 0,
                          color: dividerColor,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        letterSpacing: 0.125,
                                        color: darkText,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 56,
                              child: VerticalDivider(
                                width: 0.1,
                                color: dividerColor,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Ok",
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        letterSpacing: 0.125,
                                        color: darkText,
                                        fontWeight: FontWeight.w800),
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
          },
        );
      },
    ).whenComplete(() {
      setState(() {});
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
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    selectFilterDate(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: buttonColor,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _date,
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            color: darkText,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  physics: const ClampingScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _showPenilaian(deviceWidth, deviceHeight);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "OD00000001",
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: darkText,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            child: Row(
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
                                  child: const Center(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Image(
                                        height: 100,
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "lib/assets/images/catering1.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 35),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Alisya Catering Berkah",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: darkText,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Rp 31.500",
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: darkText,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Selesai",
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: darkText,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: buttonColor,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "5",
                                          style: GoogleFonts.inter(
                                              fontSize: 15,
                                              color: darkText,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 5,
                            height: 20,
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
