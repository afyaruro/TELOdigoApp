// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:telodigo/ui/components/customcomponents/exitconfirmation.dart';
import 'package:telodigo/ui/pages/perfil/perfil.dart';
import 'package:telodigo/ui/pages/sign_in/sign_in.dart';
import 'package:telodigo/ui/pages/sign_up/sign_up.dart';
import 'package:telodigo/ui/pages/terminos&condiciones/terminos&condiciones.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
   int _currentIndex = 0;

  final Screens = [
    terminos_condiciones(),
    sign_in(),
    sign_up(),
    terminos_condiciones(),
    Perfil(),
  ];

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
          color: Color.fromARGB(255, 29, 7, 48),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            selectedIndex: _currentIndex,
            onTabChange: (index) => {setState(() {
              _currentIndex = index;
            })},
            backgroundColor: Color.fromARGB(255, 29, 7, 48),
            iconSize: 20,
            color: Colors.white,
            activeColor: Colors.white,
            gap: 7,
            tabBackgroundColor: Color.fromARGB(255, 135, 109, 156),
            padding: EdgeInsets.all(10),
            tabs: [
              GButton(
                icon: Icons.search,
                text: "Buscar",
              ),
              GButton(
                icon: Icons.room_outlined,
                text: "Ubicacion",
              ),
              GButton(
                icon: Icons.event_available_rounded,
                text: "Reservas",
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