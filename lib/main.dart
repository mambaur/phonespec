import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phone_spec/blocs/brand_bloc/brand_bloc.dart';
import 'package:phone_spec/blocs/iphone_bloc/iphone_bloc.dart';
import 'package:phone_spec/blocs/specification_bloc/specification_bloc.dart';
import 'package:phone_spec/screens/android/android_dashboard.dart';
import 'package:phone_spec/screens/iphone/iphone_dashboard.dart';
import 'package:phone_spec/screens/others/about.dart';
import 'package:phone_spec/screens/others/disclaimer.dart';
import 'package:phone_spec/utils/http_overrides.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

String get bannerAdUnitId {
  /// Always test with test ads
  if (kDebugMode) {
    return MobileAds.bannerAdTestUnitId;
  } else {
    return 'ca-app-pub-2465007971338713/2549938883';
  }
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();
  await MobileAds.initialize(
    bannerAdUnitId: bannerAdUnitId,
  );

  // Inisial http method untuk Android versi 6 atau kebawah
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: "assets/env/.env_production");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BrandBloc(),
        ),
        BlocProvider(
          create: (context) => SpecificationBloc(),
        ),
        BlocProvider(
          create: (context) => IphoneBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'PhoneSpec',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
              elevation: 0.5,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context)
                .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ),
        ),
        home: UpgradeAlert(
            showIgnore: false,
            showReleaseNotes: false,
            showLater: false,
            child: const MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  String version = '';
  String _rateReviewUrl =
      'https://play.google.com/store/apps/details?id=com.caraguna.phonespec';
  String _saweriaUrl = 'https://saweria.co/bauroziq';
  static List<Widget> _widgetOptions = <Widget>[
    AndroidDashboard(),
    IphoneDashboard()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    setState(() {});
  }

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  void initState() {
    getPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // title: const Text('PhoneSpec'),
        title: SizedBox(
            width: 100,
            child: Image.asset('assets/images/phonespec_logo_4.png')),
        // leading: Icon(Icons.phone_android),
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.menu)),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "Phonespec",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "Temukan spesifikasi HP impianmu",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              decoration: const BoxDecoration(color: Colors.purple),
            ),
            ListTile(
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Disclaimer();
                  }));
                },
                title: const Text("Disclaimer")),
            ListTile(
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const About();
                  }));
                },
                title: const Text("Tentang Aplikasi")),
            ListTile(
                onTap: () {
                  _launchURL(_rateReviewUrl);
                },
                title: const Text("Beri Penilaian Aplikasi")),
            ListTile(
                onTap: () {
                  _launchURL(_saweriaUrl);
                },
                title: const Text("Dukung Pengembangan App")),
            ListTile(onTap: () {}, title: Text('Versi ' + version)),
          ]),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
                margin: EdgeInsets.only(bottom: 2), child: Icon(Icons.android)),
            label: 'Android',
          ),
          BottomNavigationBarItem(
            icon: Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.phone_android)),
            label: 'Iphone',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}
