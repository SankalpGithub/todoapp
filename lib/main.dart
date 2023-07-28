import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
   await Hive.initFlutter();
   var box = await Hive.openBox("mybox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: Home(),
    );
  }
}
