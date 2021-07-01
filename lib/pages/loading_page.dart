import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/map_page.dart';
import 'package:maps_app/pages/no_internet_page.dart';

class LoadingPage extends StatelessWidget {
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
    await checkGPSPermision();
    await checkInternetConnection(context);
    return Navigator.pushReplacement(
          context, navigationFadeIn(context, MapPage()));

  }

  Future checkInternetConnection(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return Navigator.pushReplacement(
          context, navigationFadeIn(context, NoInternetPage()));
    }
  }

  Future checkGPSPermision() async {
    // TODO check permission or is active
    Future.delayed(Duration(seconds: 3));
    return;
  }

}
