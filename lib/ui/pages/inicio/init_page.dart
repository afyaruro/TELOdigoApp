// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/mapcontroller.dart';
import 'package:telodigo/data/service/apimercadopago.dart';
import 'package:telodigo/ui/components/customcomponents/custombackgroundlogin.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/exitconfirmation.dart';
import 'package:telodigo/ui/pages/sign_in/sign_in.dart';
import 'package:telodigo/ui/pages/sign_up/sign_up.dart';

class Init_Page extends StatefulWidget {
  const Init_Page({super.key});

  @override
  State<Init_Page> createState() => _Init_PageState();
}

class _Init_PageState extends State<Init_Page> {

   static final MapController controller = Get.find();

  MercadoPago mercado =MercadoPago();

  @override
  void initState() {
    super.initState();

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
          body: CustomBackgroundLogin(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Container(
                padding: const EdgeInsets.all(50),
                child: const Image(
                  image: AssetImage('assets/logo.png'),
                  height: 200,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              CustomButtonsRadiusx(Colors.white,
                  const Color(0xff3B2151), "CREAR CUENTA", () async {
                   controller.getCurrentLocation();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const sign_up()));
              }),
              CustomButtonsRadiusx(const Color(0xff3B2151),
                  const Color(0xffffffff), "INICIAR SESION", () async {
                   controller.getCurrentLocation();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const sign_in()));
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
