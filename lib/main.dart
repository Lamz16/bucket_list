import 'package:bucket_list/add_bucket_list.dart';
import 'package:bucket_list/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (context) {
          return MainScreen();
        },
        "/add": (context){
          return AddBucketList();
        },
      },
      initialRoute: "/home",
    );
  }
}
