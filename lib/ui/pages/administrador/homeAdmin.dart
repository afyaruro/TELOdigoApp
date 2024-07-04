import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:telodigo/ui/components/customcomponents/exitconfirmation.dart';
import 'package:telodigo/ui/pages/administrador/GestionarInformes/ListInformes.dart';
import 'package:telodigo/ui/pages/administrador/GestionarNegocios/ListNegocios.dart';
import 'package:telodigo/ui/pages/administrador/GestionarPagos/ListPagos.dart';
import 'package:telodigo/ui/pages/administrador/GestionarUsuarios/ListUsers.dart';
import 'package:telodigo/ui/pages/administrador/nuevasOpciones.dart';

class HomeAdmin extends StatefulWidget {
  final int currentIndex;
  const HomeAdmin({
    super.key,
    this.currentIndex = 0,
  });

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _currentIndex = 0;

  final Screens = [
    const ListPagos(),
    const ListUsers(filtro: "",),
    const ListNegociosDelete(filtro: "",),
    const ListInformes(),
    const SalirAdmin(),
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
            padding: const EdgeInsets.all(10),
            tabs: const [
              GButton(
                icon: Icons.payments,
                text: "Pagos",
              ),
              GButton(
                icon: Icons.group,
                text: "Usuarios",
              ),
              GButton(
                icon: Icons.business_sharp,
                text: "Negocios",
              ),
              GButton(
                icon: Icons.error,
                text: "Informes",
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
