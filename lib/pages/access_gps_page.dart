import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessGPSPage extends StatefulWidget {
  @override
  _AccessGPSPageState createState() => _AccessGPSPageState();
}

class _AccessGPSPageState extends State<AccessGPSPage> {
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
                final status = await Permission.location.request();
                this.requestAccessGPS(status);
              },
              child: Text("Request permission"),
            )
          ],
        ),
      ),
    );
  }

  requestAccessGPS(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, "map");
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
