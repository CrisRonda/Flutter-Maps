import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/map/map_bloc.dart';
import 'package:maps_app/bloc/user_location/user_location_bloc.dart';
import 'package:maps_app/pages/access_gps_page.dart';
import 'package:maps_app/pages/loading_page.dart';
import 'package:maps_app/pages/map_page.dart';
import 'package:maps_app/pages/no_internet_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => UserLocationBloc(),
          ),
          BlocProvider(
            create: (_) => MapBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // debugShowMaterialGrid: true,
          initialRoute: 'loading',
          theme: _themeApp(),
          routes: {
            'loading': (_) => LoadingPage(),
            'map': (_) => MapPage(),
            'access_gps': (_) => AccessGPSPage(),
            'no_internet': (_) => NoInternetPage(),
          },
        ));
  }

  ThemeData _themeApp() {
    return ThemeData(
        primaryColor: Colors.grey,
        accentColor: Colors.cyan,
        scaffoldBackgroundColor: Colors.black,
        buttonColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey,
                primary: Colors.grey.shade800,
                onPrimary: Colors.white,
                elevation: 0,
                shape: StadiumBorder(),
                minimumSize: Size(100, 40))),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white),
          button: TextStyle(color: Colors.white),
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          headline3: TextStyle(color: Colors.white),
          headline4: TextStyle(color: Colors.white),
          headline5: TextStyle(color: Colors.white),
          headline6: TextStyle(color: Colors.white),
        ));
  }
}
