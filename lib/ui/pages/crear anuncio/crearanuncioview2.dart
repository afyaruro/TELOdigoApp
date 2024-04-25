import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview3.dart';

class CrearAnuncioView2 extends StatefulWidget {
  const CrearAnuncioView2({super.key});

  @override
  State<CrearAnuncioView2> createState() => _CrearAnuncioView2State();
}

class _CrearAnuncioView2State extends State<CrearAnuncioView2> {
  static final NegocioController controllerhotel = Get.find();
  TextEditingController controller = TextEditingController(text: "");
  bool btnDepartamento = false;
  bool btnHabitacion = false;
  bool btnBungalow = false;
  bool btnHotel = false;
  bool btnHostal = false;
  bool btnVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Paso 2 de 9", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 15, ),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "¿Cuál de estas opciones describe mejor tu espacio?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonOptionView(
                    nombreBtn: "Hostal",
                    btn: btnHostal,
                    action: () {
                      setState(() {
                        btnVisible = !btnHostal;
                        btnHostal = !btnHostal;
                        btnHabitacion = false;
                        btnBungalow = false;
                        btnDepartamento = false;
                        btnHotel = false;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomButtonOptionView(
                    nombreBtn: "Bungalow",
                    btn: btnBungalow,
                    action: () {
                      setState(() {
                        btnVisible = !btnBungalow;
                        btnBungalow = !btnBungalow;
                        btnHostal = false;
                        btnHabitacion = false;
                        btnDepartamento = false;
                        btnHotel = false;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonOptionView(
                    nombreBtn: "Habitación",
                    btn: btnHabitacion,
                    action: () {
                      setState(() {
                        btnVisible = !btnHabitacion;
                        btnHabitacion = !btnHabitacion;
                        btnHostal = false;
                        btnBungalow = false;
                        btnDepartamento = false;
                        btnHotel = false;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomButtonOptionView(
                    nombreBtn: "Hotel",
                    btn: btnHotel,
                    action: () {
                      setState(() {
                        btnVisible = !btnHotel;
                        btnHotel = !btnHotel;
                        btnHostal = false;
                        btnHabitacion = false;
                        btnBungalow = false;
                        btnDepartamento = false;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonOptionView(
                    nombreBtn: "Departamento",
                    btn: btnDepartamento,
                    action: () {
                      setState(() {
                        btnVisible = !btnDepartamento;
                        btnDepartamento = !btnDepartamento;
                        btnHostal = false;
                        btnHabitacion = false;
                        btnBungalow = false;
                        btnHotel = false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 120,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 16, 152, 231)),
                  onPressed: btnVisible
                      ? () {
                          if (btnDepartamento) {
                            controllerhotel.IngresarTipoEspacio("Departamento");
                          } else if (btnHostal) {
                            controllerhotel.IngresarTipoEspacio("Hostal");
                          } else if (btnHabitacion) {
                            controllerhotel.IngresarTipoEspacio("Habitacion");
                          } else if (btnBungalow) {
                            controllerhotel.IngresarTipoEspacio("Bungalow");
                          } else {
                            controllerhotel.IngresarTipoEspacio("Hotel");
                          }

                          // print(controllerhotel.tipoEspacio);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CrearAnuncioView3()));
                        }
                      : null,
                  child: Text(
                    "Siguiente",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonOptionView extends StatelessWidget {
  final String nombreBtn;
  final bool btn;
  final Function action;

  CustomButtonOptionView({
    required this.nombreBtn,
    required this.btn,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      child: ElevatedButton(
        onPressed: () => action(),
        style: ElevatedButton.styleFrom(
          backgroundColor: btn
              ? Color.fromARGB(255, 0, 0, 0)
              : const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Text(
          nombreBtn,
          style: TextStyle(
            color: btn
                ? Color.fromARGB(255, 255, 255, 255)
                : Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
