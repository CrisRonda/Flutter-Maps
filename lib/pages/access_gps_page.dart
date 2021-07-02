import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessGPSPage extends StatefulWidget {
  @override
  _AccessGPSPageState createState() => _AccessGPSPageState();
}

class _AccessGPSPageState extends State<AccessGPSPage>
    with WidgetsBindingObserver {
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
      final isGranted = await Permission.location.isGranted;
      if (!(isGranted)) {
        Navigator.pushReplacementNamed(context, "loading");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/no_permission.json',
            ),
            SizedBox(
              height: 24,
            ),
            FittedBox(
              child: Text(
                'No GPS Permissions',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () async {
                popup = true;
                final status = await Permission.location.request();
                await this.requestAccessGPS(status);
                popup = false;
              },
              child: Text("Request permission"),
            )
          ],
        ),
      ),
    );
  }

  requestAccessGPS(PermissionStatus status) async {
    print(status);
    switch (status) {
      case PermissionStatus.granted:
        final gpsIsActive = await Geolocator.isLocationServiceEnabled();
        if (gpsIsActive) {
          await Navigator.pushReplacementNamed(context, "loading");
        } else {
          openAppSettings();
        }
        break;
      case PermissionStatus.limited:
      case PermissionStatus.restricted:
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}
