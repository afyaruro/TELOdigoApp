import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/domain/models/usuario.dart';
import 'package:telodigo/ui/pages/datos%20generales/datos_generales.dart';
import 'package:telodigo/ui/pages/home%20anfitrion/homeanfitrion.dart';
import 'package:telodigo/ui/pages/inicio/init_page.dart';
import 'package:telodigo/ui/pages/perfil/informaproblema.dart';
import 'package:telodigo/ui/pages/perfil/sinHotel.dart';
import 'package:telodigo/ui/pages/terminos&condiciones/terminos&condiciones.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool modo_oscuro = false;
  Color background = const Color(0xFF1D0730);
  Color color_segundario = Color.fromARGB(255, 255, 255, 255);
  final UserController controlleruser = Get.find();

  @override
  void initState() {
    super.initState();

    PeticionesReserva.cancelarReservas(context);
    PeticionesReserva.calificar(context);
    PeticionesReserva.culminado(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            CustomTitlePerfil(
              color: color_segundario,
              text: "Perfil",
            ),
            CustomOptionPerfil(
              color: color_segundario,
              icon: Icons.person,
              text: "Datos Generales",
              action: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Datos_Generales()));
              },
            ),
            // CustomOptionPerfil(
            //   color: color_segundario,
            //   icon: Icons.settings_outlined,
            //   text: "Configuración y Privacidad",
            //   action: () {},
            // ),
            CustomTitlePerfil(
              color: color_segundario,
              text: "Tu Negocio",
            ),
            CustomOptionPerfil(
              color: color_segundario,
              icon: Icons.apartment_rounded,
              text: "Gestiona Tus Negocios",
              action: () async {
                //aqui rectifico si es el primer negocio

                if (controlleruser.usuario!.nombres == "" ||
                    controlleruser.usuario!.apellidos == "") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Configura tu Nombre",
                          style: TextStyle(fontSize: 15),
                        ),
                        content:
                            const Text("Debes configurar tu nombre y apellido"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Configurar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Datos_Generales()));
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  final CollectionReference collection =
                      FirebaseFirestore.instance.collection("Negocios");
                  var negocioCont = (await collection
                          .where('user',
                              isEqualTo: controlleruser.usuario!.userName)
                          .get())
                      .size;

                  if (negocioCont > 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeAnfitrion()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const sinHotel()));
                  }
                }
              },
            ),
            CustomTitlePerfil(
              color: color_segundario,
              text: "Otras Opciones",
            ),
            CustomOptionPerfil(
              color: color_segundario,
              icon: Icons.warning_amber_rounded,
              text: "Informar un Problema",
              action: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InformaProblema()));
              },
            ),
            CustomOptionPerfil(
              color: color_segundario,
              icon: Icons.book_rounded,
              text: "Términos y Condiciones",
              action: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const terminos_condiciones()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomCerrarSesion(controlleruser: controlleruser),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTitlePerfil extends StatelessWidget {
  const CustomTitlePerfil({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        text,
        style:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: color),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class CustomCerrarSesion extends StatelessWidget {
  const CustomCerrarSesion({
    super.key,
    required this.controlleruser,
  });

  final UserController controlleruser;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            // una barra circular indicando que se esta cerrando sesion

            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text("Cerrando Sesion..."),
                      ],
                    ),
                  );
                },
              );

              Usuario usuario = Usuario(
                  saldoCuenta: 0,
                  userName: "",
                  password: "",
                  nombres: "",
                  apellidos: "",
                  correo: "",
                  fechaNacimiento: "",
                  foto: "",
                  modoOscuro: false);

              controlleruser.DatosUser(usuario);

              Future.delayed(
                Duration(seconds: 2),
                () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Init_Page()),
                    (Route<dynamic> route) => false,
                  );
                },
              );
            },
            child: Text("CERRAR SESIÓN")));
  }
}

class CustomOptionPerfil extends StatelessWidget {
  const CustomOptionPerfil({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
    required this.action,
  });

  final Color color;
  final String text;
  final IconData icon;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(bottom: 5, top: 5),
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(
              width: 10,
            ),
            Text(text, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}

//  InkWell(
//               onTap: ,

//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 padding: EdgeInsets.only(bottom: 5, top: 5),
//                 child: Row(
//                   children: [
//                     modo_oscuro
//                         ? Icon(Icons.sunny, color: color_segundario)
//                         : Icon(Icons.bedtime, color: color_segundario),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     modo_oscuro
//                         ? Text("Cambiar a modo claro",
//                             style: TextStyle(color: color_segundario))
//                         : Text("Cambiar a modo oscuro",
//                             style: TextStyle(color: color_segundario)),
//                   ],
//                 ),
//               ),
//             ),
