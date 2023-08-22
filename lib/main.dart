//ignore_for_file: todo
import 'package:animations/animations.dart';
import 'package:catering/globals.dart';
import 'package:catering/login/login.dart';
import 'package:catering/pengantar/homepengantar.dart';
import 'package:catering/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'catering/homecatering.dart';
import 'home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserAuth(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserAuthentication(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Aplikasi Catering Food Care",
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          maxWidth: 2460,
          minWidth: 480,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET, scaleFactor: 0.9),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K", scaleFactor: 0.9)
          ],
          background: Container(
            color: const Color(0xFFF5F5F5),
          ),
        ),
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: GoogleFonts.inter(
                  color: lightText,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  letterSpacing: 0.125),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          cardColor: scaffoldBackgroundColor,
          textTheme: GoogleFonts.interTextTheme(
            TextTheme(
              displayLarge: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.w700,
                fontSize: 101,
                letterSpacing: -0.15,
              ),
              displayMedium: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.w700,
                fontSize: 63,
                letterSpacing: -0.015,
              ),
              displaySmall: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.w700,
                fontSize: 50,
                letterSpacing: 0.0,
              ),
              headlineMedium: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.w700,
                fontSize: 36,
                letterSpacing: 0.025,
              ),
              headlineSmall: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.w700,
                fontSize: 25,
                letterSpacing: 0,
              ),
              titleLarge: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.w700,
                fontSize: 21,
                letterSpacing: 0.015,
              ),
              titleMedium: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.normal,
                fontSize: 17,
                letterSpacing: 0.015,
              ),
              titleSmall: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.01,
              ),
              bodyLarge: GoogleFonts.nunito(
                color: lightText,
                fontWeight: FontWeight.normal,
                fontSize: 17,
                letterSpacing: 0.05,
              ),
              bodyMedium: GoogleFonts.nunito(
                  color: darkText,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  letterSpacing: 0.025),
              labelLarge: GoogleFonts.nunito(
                color: primaryColorVariant,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.125,
              ),
              bodySmall: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.normal,
                fontSize: 12,
                letterSpacing: 0.04,
              ),
              labelSmall: GoogleFonts.nunito(
                color: darkText,
                fontWeight: FontWeight.normal,
                fontSize: 10,
                letterSpacing: 0.15,
              ),
            ),
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: primaryColor, secondary: primaryColorVariant),
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.windows: SharedAxisPageTransitionsBuilder(
                  transitionType: SharedAxisTransitionType.horizontal),
            },
          ),
        ),
        home: const MyApp(),
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
      ),
    ),
  );
}

class UserAuth with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setIsLoggedIn(val) {
    _isLoggedIn = val;
    notifyListeners();
  }
}

class UserAuthentication with ChangeNotifier {
  String _loginStatus = "false";
  String _idUser = "";

  String get loginStatus => _loginStatus;
  String get kodeUser => _idUser;

  void setUserAuthentication(loginStatus, idUser) {
    _loginStatus = loginStatus;
    _idUser = kodeUser;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getAuthPref().whenComplete(() {
      debugPrint(userID);
      debugPrint("$userStatus");
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
    Future.delayed(const Duration(seconds: 1));
    if (userID != "" && userStatus != 0) {
      if (userStatus == 1) {
        return const HomePage();
      } else if (userStatus == 2) {
        return const HomeCateringPage();
      } else {
        return const HomePengantarPage();
      }
    } else {
      return const MainLoginPage();
    }
  }
}


//run on release mode : lbh ringan & smooth
// flutter run --release