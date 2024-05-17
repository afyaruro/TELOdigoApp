import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:telodigo/data/service/apimercadopago.dart';
import 'dart:convert';

import 'package:telodigo/ui/pages/prueba/peticionesMPCustomer.dart';
import 'package:uuid/uuid.dart';

class PeticionesMPCard {
  static String token =
      "APP_USR-8145439094998072-051100-dba743e01c1761805e05c0aaaa2b4b2b-415512808";
  static MercadoPago m = MercadoPago();

  static Future<String> asociarTarjetaACliente() async {
    final cardData = {
      'card_number': '5247083812260782',
      'security_code': '729',
      'expiration_month': '04',
      'expiration_year': '2029',
      'cardholder': {
        "name": "andres",
      }
    };

    var tokenCard = await getCardtoken2(cardData);

    var customerId = await PeticionesMPCustomer.crearCustomer();
    if (customerId != "error") {
      String url = 'https://api.mercadopago.com/v1/customers/$customerId/cards';

      Map<String, dynamic> datosTarjeta = {"token": tokenCard['result']['id']};
      print(tokenCard['result']['id']);
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(datosTarjeta),
        );

        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode <= 205) {
          print('Tarjeta asociada con éxito');
        } else {
          print('Error al asociar la tarjeta: ${response.body}');
        }
      } catch (error) {
        print('Error al asociar la tarjeta: $error');
      }
    } else {
      //Alerta de error customer
    }

    return tokenCard['result']['id'];
  }

  static Future getCardtoken2(Map<String, dynamic> requestBody) async {
    String url = 'https://api.mercadopago.com/v1/card_tokens';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(requestBody));

      // print(response.body);

      if (response.statusCode >= 200 && response.statusCode <= 205) {
        return {
          "result": json.decode(response.body),
          "message": response.reasonPhrase,
          "error": null
        };
      } else {
        return {"result": null, "message": response.body, "error": null};
      }
    } catch (e) {
      return {"result": null, "message": "Error", "error": e.toString()};
    }
  }

  static Future<void> obtenerTarjetas() async {
    var customerId = await PeticionesMPCustomer.crearCustomer();

    String url = 'https://api.mercadopago.com/v1/customers/$customerId/cards';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // La solicitud se realizó con éxito
        print('Tarjetas del cliente:');
        print(response.body);
      } else {
        // Manejar el error en caso de que la solicitud falle
        print('Error al obtener las tarjetas del cliente: ${response.body}');
      }
    } catch (error) {
      // Manejar errores de conexión u otros
      print('Error al realizar la solicitud: $error');
    }
  }


  static Future<void> realizarPago(String tokenT) async {
  String url = 'https://api.mercadopago.com/v1/payments';

  String requestBody = json.encode({
    "installments": 1, //cuotas en caso tal de credio
    "binary_mode": false,
    "capture": true, 
    "payer": {
      "email": "andresyaruro20@gmail.com",
    },
    "payment_method_id": "master", 
    "token": tokenT,
    "transaction_amount": 1051, 
    "description": "Recarga de Hotel Telodigo",
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

    print(response.statusCode);

    if (response.statusCode == 200) {
      // La solicitud se realizó con éxito
      print('Pago exitoso:');
      print(response.body);
    } else {
      // Manejar el error en caso de que la solicitud falle
      print('Error al realizar el pago: ${response.body}');
    }
  } catch (error) {
    // Manejar errores de conexión u otros
    print('Error al realizar la solicitud: $error');
  }
}


}
