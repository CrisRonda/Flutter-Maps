import 'package:flutter/material.dart';
import 'package:maps_app/painters/custom_markers.dart';

class PinMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: 350,
          height: 150,
          // color: Colors.red,
          child: CustomPaint(
            // painter: DestinationMarker("Holasss mundo desde EcHola mundo desde EcHola mundo desde EcHola mundo desde Ecuador para el mundo desde mi casa", 213322.13) ,
            painter: InitialMarker(32) ,

          ),
        ),
      ),
    );
  }
}