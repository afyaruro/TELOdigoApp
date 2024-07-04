import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesadmin.dart';
import 'package:telodigo/domain/models/solicitdPago.dart';
import 'package:telodigo/ui/pages/administrador/GestionarNegocios/viewNegocioDelete.dart';
import 'package:telodigo/ui/pages/administrador/homeAdmin.dart';

class DetallePago extends StatelessWidget {
  final SolicitudPago pago;

  DetallePago({required this.pago});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: "");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle del Pago',
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Monto:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 109, 219)),
              ),
              Text(
                '\$${pago.monto}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
              const Text(
                'User Anfitrión:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 109, 219)),
              ),
              Text(
                pago.userAnfitrion,
                style: const TextStyle(color: Colors.white),
              ),

              const Text(
                'Banco:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 109, 219)),
              ),
              Text(
                pago.banco,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),

              const Text(
                'N° Cuenta:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 109, 219)),
              ),
              Text(
                pago.numeroCuenta,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nombre del titular:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 109, 219)),
              ),
              Text(
                pago.nombreTitular,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),

              const Text(
                'Celular de contacto:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 109, 219)),
              ),
              Text(
                pago.celularContacto,
                style: const TextStyle(color: Colors.white),
              ),
              // const SizedBox(height: 10),
              // const Text(
              //   'Estado:',
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: Color.fromARGB(255, 142, 109, 219)),
              // ),
              // Text(
              //   pago.estado,
              //   style: const TextStyle(color: Colors.white),
              // ),
              const SizedBox(height: 10),
              const Text(
                'Concepto:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 109, 219)),
              ),
              Text(
                pago.concepto,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Motivo:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 109, 219)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 221, 219, 219),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Escribe aquí...',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              Center(
                child: Wrap(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Color de fondo
                        ),
                        onPressed: () {
                          if (controller.text == "") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context2) {
                                return AlertDialog(
                                  title: const Text("Escribe un motivo"),
                                  content: const Text(
                                      "Por favor ingresa un motivo del pago"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context2).pop();
                                      },
                                      child: Text("Aceptar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(width: 30),
                                      Text("Actualizando..."),
                                    ],
                                  ),
                                );
                              },
                            );

                            showPasswordDialog(context, () async {
                              bool resp =
                                  await PeticionesAdmin.ActualizarEstadoPago(
                                      controller.text,
                                      "Rechazado",
                                      pago.id,
                                      pago.userAnfitrion,
                                      pago.monto);
                              if (resp) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeAdmin(
                                              currentIndex: 0,
                                            )));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context2) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          "No hemos podido actualizar el estado del pago"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context2).pop();
                                          },
                                          child: Text("Aceptar"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            });
                          }
                        },
                        child: Text(
                          "Rechazar",
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Color de fondo
                        ),
                        onPressed: () {
                          if (controller.text == "") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context2) {
                                return AlertDialog(
                                  title: const Text("Escribe un motivo"),
                                  content: const Text(
                                      "Por favor ingresa un motivo del pago"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context2).pop();
                                      },
                                      child: Text("Aceptar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(width: 30),
                                      Text("Actualizando..."),
                                    ],
                                  ),
                                );
                              },
                            );

                            showPasswordDialog(context, () async {
                              bool resp =
                                  await PeticionesAdmin.ActualizarEstadoPago(
                                      controller.text,
                                      "Pagado",
                                      pago.id,
                                      pago.userAnfitrion,
                                      pago.monto);
                              if (resp) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeAdmin(
                                              currentIndex: 0,
                                            )));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context2) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          "No hemos podido actualizar el estado del pago"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context2).pop();
                                          },
                                          child: Text("Aceptar"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            });
                          }
                        },
                        child: Text(
                          "Pagado",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
