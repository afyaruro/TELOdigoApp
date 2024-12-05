import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/components/customcomponents/customdatepicker.dart';
import 'package:telodigo/ui/components/customcomponents/customimage.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/components/respuestas/respuesta_datos_personales.dart';

class Datos_Generales extends StatefulWidget {
  const Datos_Generales({super.key});

  @override
  State<Datos_Generales> createState() => _Datos_GeneralesState();
}

class _Datos_GeneralesState extends State<Datos_Generales> {
  static final UserController controlleruser = Get.find();

  final TextEditingController controller_nombres =
      TextEditingController(text: controlleruser.usuario!.nombres);

  final TextEditingController controller_apellidos =
      TextEditingController(text: controlleruser.usuario!.apellidos);

  final TextEditingController controller_fecha =
      TextEditingController(text: controlleruser.usuario!.fechaNacimiento);

  final TextEditingController controller_img =
      TextEditingController(text: controlleruser.usuario!.foto);

  bool modo_oscuro = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        title: Text(
          "Datos Generales",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 29, 7, 48),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImagenPerfil(imagebyte: controller_img),
              Container(
                  width: 400,
                  margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Text(
                    "Nombres y Apellidos",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: modo_oscuro
                            ? Colors.white
                            : Color.fromARGB(190, 0, 0, 0),
                        fontWeight: FontWeight.w500),
                  )),
              modo_oscuro
                  ? CustomTextField1(
                      nombre: "Nombres",
                      isPassword: false,
                      controller: controller_nombres,
                    )
                  : CustomTextField3("Nombres", controller_nombres),
              modo_oscuro
                  ? CustomTextField1(
                      nombre: "Apellidos",
                      isPassword: false,
                      controller: controller_apellidos,
                    )
                  : CustomTextField3("Apellidos", controller_apellidos),
              Container(
                  width: 400,
                  margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Text(
                    "Fecha de Nacimiento",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: modo_oscuro
                            ? Colors.white
                            : Color.fromARGB(190, 0, 0, 0),
                        fontWeight: FontWeight.w500),
                  )),
              modo_oscuro
                  ? CustomDatePicker(controller: controller_fecha)
                  : CustomDatePicker1(controller: controller_fecha),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (controller_nombres.text.trim().isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Verifica tu Información",
                            text: "Los nombres no pueden ser vacio",
                          );
                        },
                      );
                      return;
                    }

                    if (!RegExp(r"^[a-zA-ZÀ-ÿ\s'-]+$")
                        .hasMatch(controller_nombres.text)) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Verifica tu Información",
                            text:
                                "Los nombres solo pueden contener letras, espacios, guiones y apóstrofes.",
                          );
                        },
                      );
                      return;
                    }

                    if (controller_nombres.text.length < 3) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Verifica tu Información",
                            text:
                                "Los nombres deben tener al menos 3 caracteres.",
                          );
                        },
                      );
                      return;
                    }

                    if (controller_apellidos.text.trim().isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Verifica tu Información",
                            text: "Los apellidos no pueden ser vacio",
                          );
                        },
                      );
                      return;
                    }

                    if (!RegExp(r"^[a-zA-ZÀ-ÿ\s'-]+$")
                        .hasMatch(controller_apellidos.text)) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Verifica tu Información",
                            text:
                                "Los apellidos solo pueden contener letras, espacios, guiones y apóstrofes.",
                          );
                        },
                      );
                      return;
                    }

                    if (controller_apellidos.text.length < 3) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Verifica tu Información",
                            text:
                                "Los apellidos deben tener al menos 3 caracteres.",
                          );
                        },
                      );
                      return;
                    }

                    bool resp = await respuestaActualizarDatos(
                        nombres: controller_nombres.text,
                        apellidos: controller_apellidos.text,
                        fechaNacimiento: controller_fecha.text,
                        foto: controller_img.text,
                        userName: controlleruser.usuario!.userName,
                        context: context);

                    if (resp == true || resp == false) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                  child: const Text("Guardar")),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
