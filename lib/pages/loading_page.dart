import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/access_gps_page.dart';
import 'package:maps_app/pages/map_page.dart';
import 'package:maps_app/pages/no_internet_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  bool popup = false;
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && !popup) {
      final gpsIsActive = await Geolocator.isLocationServiceEnabled();
      if (gpsIsActive) {
        Navigator.pushReplacementNamed(context, "map");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: this.checkStatus(context),
        builder: (_, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/loading_pin.json',
                repeat: false,
              ),
              SizedBox(
                height: 40,
                child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        WavyAnimatedText(
                          'Loading',
                          speed: Duration(milliseconds: 312),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future checkStatus(BuildContext context) async {
    popup = true;
    Widget pageToNav = MapPage();
    final locationPermissionGranted = await Permission.location.isGranted;
    final gpsIsActive = await Geolocator.isLocationServiceEnabled();

    if (!locationPermissionGranted || !gpsIsActive) {
      pageToNav = AccessGPSPage();
    }
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      pageToNav = NoInternetPage();
    }
    await Future.delayed(Duration(seconds: 4));
    if (popup) {
      Navigator.pushReplacement(context, navigationFadeIn(context, pageToNav));
    }
    popup = false;
  }
}
