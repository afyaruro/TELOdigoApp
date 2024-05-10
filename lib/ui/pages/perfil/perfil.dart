import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/usuario.dart';
import 'package:telodigo/ui/pages/datos%20generales/datos_generales.dart';
import 'package:telodigo/ui/pages/home%20anfitrion/homeanfitrion.dart';
import 'package:telodigo/ui/pages/inicio/init_page.dart';
import 'package:telodigo/ui/pages/terminos&condiciones/terminos&condiciones.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool modo_oscuro = false;
  Color background = Color.fromARGB(255, 29, 7, 48);
  Color color_segundario = Color.fromARGB(255, 255, 255, 255);
  final UserController controlleruser = Get.find();

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
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Datos_Generales()));
              },
            ),
            CustomOptionPerfil(
              color: color_segundario,
              icon: Icons.settings_outlined,
              text: "Configuración y Privacidad",
              action: () {},
            ),
            CustomTitlePerfil(
              color: color_segundario,
              text: "Tu Negocio",
            ),
            CustomOptionPerfil(
              color: color_segundario,
              icon: Icons.apartment_rounded,
              text: "Gestiona Tus Negocios",
              action: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => HomeAnfitrion()));
              },
            ),
            CustomTitlePerfil(
              color: color_segundario,
              text: "Otras Opciones",
            ),
            
            CustomOptionPerfil(
              color: color_segundario,
              icon: Icons.question_answer_rounded,
              text: "Preguntas Frecuentes",
              action: () {},
            ),
            CustomOptionPerfil(
              color: color_segundario,
              icon: Icons.warning_amber_rounded,
              text: "Informar un Problema",
              action: () {},
            ),
            CustomOptionPerfil(
              color: color_segundario,
              icon: Icons.book_rounded,
              text: "Terminos y Condiciones",
              action: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => terminos_condiciones()));
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
                    CupertinoPageRoute(builder: (context) => const Init_Page()),
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