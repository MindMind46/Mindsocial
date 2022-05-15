import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mindsocial/states/authen.dart';
import 'package:mindsocial/states/my_sevice.dart';

final Map<String, WidgetBuilder> map = {
  '/authen':(context) => const Authen(),
  '/myService':(context) => const MySevice(),
};

String? initial;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        initial = '/authen';
        runApp(const MyApp());
      } else {
        initial = '/myService';
        runApp(const MyApp());
      }
    });

  
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: initial,
    );
  }
}
