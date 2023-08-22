import 'package:catering/login/loginmain.dart';
import 'package:catering/login/registmain.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLoginPage extends StatefulWidget {
  const MainLoginPage({super.key});

  @override
  State<MainLoginPage> createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Selamat Datang",
                      style: GoogleFonts.nunito(
                          fontSize: 35,
                          letterSpacing: 0.125,
                          color: buttonColor,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Silahkan masukkan username dan password yang telah terdaftar untuk lanjut ke halaman berikutnya",
                      textAlign: TextAlign.end,
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          letterSpacing: 0.125,
                          color: darkText,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(height: 50),
                  const Center(
                    child: Image(
                      width: 250,
                      height: 250,
                      image: AssetImage(
                        "lib/assets/images/Catering Logo App.png",
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TabBar(
                        onTap: (index) {
                          setState(() {});
                        },
                        controller: _tabController,
                        isScrollable: false,
                        labelColor: lightText,
                        indicatorColor: Colors.transparent,
                        unselectedLabelColor: darkText,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: buttonColor,
                        ),
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        labelStyle: GoogleFonts.nunito(
                            color: lightText,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            letterSpacing: 0.125),
                        tabs: const <Widget>[
                          Tab(
                            text: "Login",
                          ),
                          Tab(
                            text: "Register",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 35, 10, 0),
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          LoginMain(),
                          RegisterMain(),
                        ],
                      ),
                    ),
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
