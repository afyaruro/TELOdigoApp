import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:telodigo/domain/models/solicitdPago.dart'; // Importa el modelo de datos

class DetalleSolicitudPago extends StatelessWidget {
  final SolicitudPago
      solicitudPago; // La solicitud de pago que se mostrará en esta vista

  DetalleSolicitudPago({required this.solicitudPago});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalle de Solicitud",
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 400,
                  child: Text(
                    "Monto: S/${solicitudPago.monto}",
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 145, 43, 228)),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                child: Text(
                  "Banco:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                  width: 400,
                  child: Text(
                    solicitudPago.banco,
                    style: const TextStyle(color: Colors.white),
                  )),

              const SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                child: Text(
                  "N° Cuenta:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                  width: 400,
                  child: Text(
                    solicitudPago.numeroCuenta,
                    style: const TextStyle(color: Colors.white),
                  )),

              const SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                child: Text(
                  "Titular de la cuenta:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                  width: 400,
                  child: Text(
                    solicitudPago.nombreTitular,
                    style: const TextStyle(color: Colors.white),
                  )),

              const SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                child: Text(
                  "Numero de contacto:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                  width: 400,
                  child: Text(
                    solicitudPago.celularContacto,
                    style: const TextStyle(color: Colors.white),
                  )),

              const SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                child: Text(
                  "Concepto:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                  width: 400,
                  child: Text(
                    solicitudPago.concepto,
                    style: const TextStyle(color: Colors.white),
                  )),
              const SizedBox(height: 10),
              Container(
                width: 400,
                child: Text(
                  "Fecha:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                width: 400,
                child: Text(
                  "${solicitudPago.fecha.day.toString().padLeft(2, '0')}/${solicitudPago.fecha.month.toString().padLeft(2, '0')}/${solicitudPago.fecha.year} - ${solicitudPago.fecha.hour.toString().padLeft(2, '0')}:${solicitudPago.fecha.minute.toString().padLeft(2, '0')}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 400,
                child: Text(
                  "Estado:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                width: 400,
                child: Text(
                  solicitudPago.estado,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: solicitudPago.estado == "En espera"
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : solicitudPago.estado == "Rechazado"
                              ? Colors.red
                              : Colors.green),
                ),
              ),


              solicitudPago.motivo.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: 400,
                          child: Text(
                            "Motivo:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                            width: 400,
                            child: Text(
                              solicitudPago.motivo,
                              style: const TextStyle(color: Colors.white),
                            )),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 10),
              // Agrega más widgets para mostrar otros detalles de la solicitud de pago si es necesario
            ],
          ),
        ),
      ),
    );
  }
}
