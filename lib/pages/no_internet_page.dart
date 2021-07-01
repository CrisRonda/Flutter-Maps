import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/offline.json',
              repeat: false,
            ),
            SizedBox(height: 24,),
            SizedBox(
              height: 40,
              child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'No internet',
                        speed: Duration(milliseconds: 312),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
