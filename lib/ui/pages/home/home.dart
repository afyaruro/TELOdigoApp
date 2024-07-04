// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:telodigo/ui/components/customcomponents/exitconfirmation.dart';
import 'package:telodigo/ui/pages/Reservar/listreservauser.dart';
import 'package:telodigo/ui/pages/favoritos/listfavoritos.dart';
import 'package:telodigo/ui/pages/mapa%20principal/mapahotels.dart';
import 'package:telodigo/ui/pages/negocios%20lista/principal.dart';
import 'package:telodigo/ui/pages/perfil/perfil.dart';

class HomeUser extends StatefulWidget {
  final int currentIndex;
  const HomeUser({
    super.key,
    this.currentIndex = 2,
  });

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  int _currentIndex = 0;

  final Screens = [
    
    Principal(),
    ListReservasUser(),
    MapaHotels(),
    Favoritos(),
    Perfil(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Mostrar la alerta y esperar la respuesta del usuario
        bool exits = await showDialog(
          context: context,
          builder: (context) => ExitConfirmationDialog(),
        );
        if (exits) {
          exit(0);
        }
        // Devolver false para evitar que la acción de retroceso continúe
        return false;
      },
      child: Scaffold(
        body: Screens[_currentIndex],
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 29, 7, 48),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            selectedIndex: _currentIndex,
            onTabChange: (index) => {
              setState(() {
                _currentIndex = index;
              })
            },
            backgroundColor: Color.fromARGB(255, 29, 7, 48),
            iconSize: 20,
            color: Colors.white,
            activeColor: Colors.white,
            gap: 7,
            tabBackgroundColor: Color.fromARGB(255, 135, 109, 156),
            padding: EdgeInsets.all(10),
            tabs: const [
              
              GButton(
                icon: Icons.search,
                text: "Buscar",
              ),
              GButton(
                icon: Icons.event_available_rounded,
                text: "Reservas",
              ),
              GButton(
                icon: Icons.room_outlined,
                text: "POINTS",
              ),
              GButton(
                icon: Icons.favorite_border,
                text: "Favoritos",
              ),
              GButton(
                icon: Icons.person,
                text: "Perfil",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
