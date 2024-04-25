import 'package:flutter/material.dart';

class CustomBackgroundLogin extends StatelessWidget {

  final Widget child;

  const CustomBackgroundLogin({
    super.key, required this.child,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff3B2151), Color(0xff08000F)],
                stops: [0.0, 0.9],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        child: child);
  }
}