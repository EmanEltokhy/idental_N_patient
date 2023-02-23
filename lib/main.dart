// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental_n_patient/layout/home_screen.dart';
// import 'package:idental_n_patient/screens/appointment_screen.dart';
// import 'package:idental_n_patient/screens/appoit_screen.dart';
// import 'package:idental_n_patient/shared/bloc_observer.dart';
// import 'package:idental_n_patient/upload.dart';
import './getting_started_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: DoctorDetailPage(),
      home: GettingStartedScreen(),
    );
  }
}
