import 'package:flutter/material.dart';
import 'package:telodigo/ui/pages/anuncios%20anfitrion/anunciosanfitrion.dart';

class sinHotel extends StatelessWidget {
  const sinHotel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1D0730),
          foregroundColor: Colors.white,
        ),
        backgroundColor: const Color(0xFF1D0730),
        body: FirstHotel());
  }
}
