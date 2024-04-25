
import 'package:flutter/material.dart';
import 'package:telodigo/ui/pages/inicio/init_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Init_Page(),
      title: "TELOdigo",
      debugShowCheckedModeBanner: false,

    );
  }
}