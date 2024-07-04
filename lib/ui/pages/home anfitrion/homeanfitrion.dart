// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/components/customcomponents/exitconfirmation.dart';
import 'package:telodigo/ui/pages/Reportes/Reportes.dart';
import 'package:telodigo/ui/pages/Reservar/listreservasanfitrion.dart';
import 'package:telodigo/ui/pages/anuncios%20anfitrion/anunciosanfitrion.dart';
import 'package:telodigo/ui/pages/chats/verchats.dart';
import 'package:telodigo/ui/pages/opciones%20anfitrion/opcionesanfitrion.dart';

class HomeAnfitrion extends StatefulWidget {
  final int currentIndex;
  const HomeAnfitrion({super.key, this.currentIndex = 0});

  @override
  State<HomeAnfitrion> createState() => _HomeAnfitrionState();
}



class _HomeAnfitrionState extends State<HomeAnfitrion> {
  int _currentIndex = 0;
  List<Hoteles> hoteles = [];

 

  final Screens = [
    const AnunciosAnfitrion(),
    const VerChats(),
    const ListReservasUserAnfitrion(),
    const Reportes(),
    const OpcionesAnfitrion(),
  ];


     @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exits = await showDialog(
          context: context,
          builder: (context) => ExitConfirmationDialog(),
        );
        if (exits) {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
        body: Screens[_currentIndex],
        bottomNavigationBar: Container(
          color: Color.fromARGB(255, 29, 7, 48),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            tabs: [
              GButton(
                icon: Icons.apartment_outlined,
                text: "Anuncios",
              ),
              GButton(
                icon: Icons.forum,
                text: "Chat",
              ),
              GButton(
                icon: Icons.event_available_rounded,
                text: "Reservas",
              ),
              GButton(
                icon: Icons.leaderboard_rounded,
                text: "Balance",
              ),
              GButton(
                icon: Icons.settings,
                text: "Opciones",
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
