import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wortcat/pages/homepage.dart';
import 'package:wortcat/pages/listpage.dart';
import 'package:wortcat/util/adddialog.dart';
import 'package:wortcat/util/playdialog.dart';
void main()async {
  await Hive.initFlutter();
  var box=await Hive.openBox('wortchatz');
  var settings=await Hive.openBox('settings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Homepage(),
      routes: {
        'home':(context)=>Listpage(),
        'add':(context)=>Playdialog()
      },
    );
  }
}

