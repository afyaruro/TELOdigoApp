import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/data/service/peticionesPagos.dart';
import 'package:telodigo/data/service/peticionesReporte.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/home%20anfitrion/homeanfitrion.dart';
import 'package:telodigo/ui/pages/home/home.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class PagoDirecto {
  static final UserController controlleruser = Get.find();

  static String token =
      // "TEST-1814742181125388-052217-fce970961294267042b2289a9a1fa9c9-1760458236";
      "APP_USR-1814742181125388-052217-c8dce3d871f08bec7547dc3ba349cca9-1760458236"; //prueba

  static Future<void> realizarPagoDirecto(
      {required BuildContext context,
      required String motivo,
      required String tarjeta,
      required String fecha,
      required String codigo,
      required String nombre,
      required double saldo,
      required Reserva reserva,
      required String idNegocio}) async {
    mostrarAlertaSimple(context: context);
    tarjeta = tarjeta.replaceAll(" ", "");
    String anioString = "00";
    List<String> partes = fecha.split("/");
    String mes = partes[0];
    if (partes.length == 2) {
      anioString = partes[1];
    }

    print(anioString);

    // Datos de la tarjeta de prueba
    final cardData = {
      'card_number': tarjeta, // Mastercard de prueba 5031755734530604
      'security_code': codigo, //123
      'expiration_month': mes, //11
      'expiration_year': "20$anioString", //2025
      'cardholder': {
        "name": nombre, //APRO
      }
    };

    // Obtener el token de la tarjeta
    var tokenCard = await _getCardToken(
      cardData,
      context,
      saldo,
      motivo,
      reserva,
    );
    if (tokenCard['result'] == null) {
      print('Error al obtener el token de la tarjeta: ${tokenCard['message']}');
      return;
    }

    // Realizar el pago
    String cardToken = tokenCard['result']['id'];
    await _realizarPago(
        cardToken: cardToken,
        context: context,
        motivo: motivo,
        saldo: saldo, //saldo
        idNegocio: idNegocio,
        reserva: reserva,
        nombre: nombre);
  }

  static Future<Map<String, dynamic>> _getCardToken(
      Map<String, dynamic> requestBody,
      BuildContext context,
      double saldo,
      String motivo,
      Reserva reserva) async {
    String url = 'https://api.mercadopago.com/v1/card_tokens';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "result": json.decode(response.body),
          "message": response.reasonPhrase,
          "error": null
        };
      } else {
        Navigator.of(context).pop();
        await descontarHabitacion(motivo, reserva);

        mostrarAlertaExito(
            funcion: () {
              Navigator.of(context).pop();
            },
            color: Color.fromARGB(255, 218, 5, 5),
            icon: Icons.credit_card,
            context: context,
            title: "Tarjeta Rechazada",
            mensaje: "Su tarjeta ha sido rechazada",
            monto: saldo);

        return {"result": null, "message": response.body, "error": null};
      }
    } catch (e) {
      await descontarHabitacion(motivo, reserva);
      Navigator.of(context).pop();

      mostrarAlertaExito(
          funcion: () {
            Navigator.of(context).pop();
          },
          color: Color.fromARGB(255, 218, 5, 5),
          icon: Icons.credit_card,
          context: context,
          title: "Tarjeta Rechazada",
          mensaje: "Su tarjeta ha sido rechazada",
          monto: saldo);

      return {"result": null, "message": "Error", "error": e.toString()};
    }
  }

  static Future<void> _realizarPago(
      {required String cardToken,
      required BuildContext context,
      required String motivo,
      required double saldo,
      required String nombre,
      required Reserva reserva,
      required String idNegocio}) async {
    String url = 'https://api.mercadopago.com/v1/payments';

    String requestBody = json.encode({
      "installments": 1,
      "binary_mode": false,
      "capture": true,
      "payer": {
        "email": controlleruser.usuario!.correo,
        "first_name": nombre,
        // "last_name": "Doe",
        // "identification": {
        //   "type": "DNI",
        //   "number": "12345678"
        // },
        // "address": {
        //   "zip_code": "12345",
        //   "street_name": "Calle Falsa",
        //   "street_number": 123
        // },
        // "phone": {
        //   "area_code": "11",
        //   "number": "123456789"
        // }
      },
      "token": cardToken,
      "transaction_amount": saldo,
      "description": "$motivo de Hotel Telodigo",
    });

    try {
      var idempotencyKey = Uuid().v4();
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'X-Idempotency-Key': idempotencyKey,
        },
        body: requestBody,
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = json.decode(response.body);
        print('Pago exitoso:');
        print(responseBody);
        String status = responseBody['status'];
        String statusDetail = responseBody['status_detail'];
        if (status == "approved") {
          print("Pago aprovado alerta custom");
          if (motivo == "Recarga") {
            await PeticionesPagos.ActualizarSaldoNegocio(idNegocio, saldo);
            Navigator.of(context).pop();
            mostrarAlertaExito(
                funcion: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeAnfitrion(
                                currentIndex: 4,
                              )));
                },
                context: context,
                color: const Color.fromARGB(255, 26, 206, 119),
                icon: Icons.check_circle,
                title: "Pago Exitoso",
                mensaje: "Su negocio ha sido recargado exitosamente",
                monto: saldo);
          } else {
            double comision = saldo * 0.05;
            await PeticionesPagos.ActualizarSaldoReserva(idNegocio, comision);

            await descontarHabitacion(motivo, reserva);

            var resp =
                await PeticionesReserva.RegistrarReserva(reserva, context);

            if (resp == "create") {
              await PeticionesReporte.addReporteNumeroReserva(
                  reserva.idUserHotel);
              await PeticionesReporte.reportePagoAdd(
                  reserva.idUserHotel, saldo);
              await PeticionesPagos.generarPago(reserva.idUserHotel, saldo);
              Navigator.of(context).pop();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(
                        child: Text(
                      "¡Tu reserva ha sido confirmada con éxito!",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                    content: Container(
                      height: 140,
                      child: Column(
                        children: [
                          Text(
                              "Tu código es ${reserva.codigo}, recuerda que te lo pedirán en el establecimiento."),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            child: Text('Ir a mis reservas'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeUser(
                                            currentIndex: 1,
                                          )));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(
                        child: Text(
                      "TOLERANCIA DE 1 HORA",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                    content: Container(
                      height: 140,
                      child: Column(
                        children: [
                          const Text(
                              "Recuerda que tienes MÁXIMO 1 HORA PARA LLEGAR al establecimiento seleccionado, ¡DATE PRISA!"),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            child: const Text('Aceptar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlert(
                    title: "Presentamos Errores",
                    text: "No hemos podido crear tu reserva",
                  );
                },
              );

              //volver a habilitar el boton
            }
          }
        } else if (status == "rejected" &&
            statusDetail == "cc_rejected_insufficient_amount") {
          await descontarHabitacion(motivo, reserva);

          Navigator.of(context).pop();
          mostrarAlertaExito(
              funcion: () {
                Navigator.of(context).pop();
              },
              color: Color.fromARGB(255, 218, 5, 5),
              icon: Icons.error,
              context: context,
              title: "Fondos Insuficientes",
              mensaje: "Sus fondos son insuficientes para realizar este pago",
              monto: saldo);
        } else {
          await descontarHabitacion(motivo, reserva);

          Navigator.of(context).pop();

          mostrarAlertaExito(
              funcion: () {
                Navigator.of(context).pop();
              },
              color: Color.fromARGB(255, 218, 5, 5),
              icon: Icons.error,
              context: context,
              title: "Pago Rechazado",
              mensaje:
                  "Su pago ha sido rechazado, por favor verifique los datos de su tarjeta",
              monto: saldo);

          print("Pago rechazado alerta custom Eliminar el pago aqui");
        }
      } else {
        await descontarHabitacion(motivo, reserva);

        Navigator.of(context).pop();
        mostrarAlertaExito(
            funcion: () {
              Navigator.of(context).pop();
            },
            color: Color.fromARGB(255, 218, 5, 5),
            icon: Icons.error,
            context: context,
            title: "Error",
            mensaje: "Ha surgido un error al realizar el pago",
            monto: saldo);
        print("Error al realizar el pago custom");
      }
    } catch (error) {
      await descontarHabitacion(motivo, reserva);
      Navigator.of(context).pop();
      mostrarAlertaExito(
          funcion: () {
            Navigator.of(context).pop();
          },
          color: Color.fromARGB(255, 218, 5, 5),
          icon: Icons.error,
          context: context,
          title: "Error",
          mensaje: "Ha surgido un error al realizar el pago",
          monto: saldo);
      print('Error al realizar la solicitud: $error');
    }
  }

  static Future<void> descontarHabitacion(
      String motivo, Reserva reserva) async {
    if (motivo == "Reserva") {
      await PeticionesReserva.actualizarCantidadHabitacion(
          idHotel: reserva.idHotel,
          nombreHabitacion: reserva.habitacion,
          operacion: "suma");
    }
  }
}

void mostrarAlertaExito(
    {required BuildContext context,
    required double monto,
    required Function funcion,
    required String mensaje,
    required IconData icon,
    required Color color,
    required String title}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: MediaQuery.of(context)
              .size
              .width, // Ajusta el ancho según sea necesario

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: color,
                      size: 60,
                    ),
                    Text(
                      title,
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Monto: S/${monto}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              funcion();
            },
          ),
        ],
      );
    },
  );
}

void mostrarAlertaSimple({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
            child: Text(
          "Cargando...",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        )),
      );
    },
  );
}
