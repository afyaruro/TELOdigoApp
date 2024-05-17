import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeticionesMPCustomer {
  static String token =
      "APP_USR-8145439094998072-051100-dba743e01c1761805e05c0aaaa2b4b2b-415512808";

  static Future<String> crearCustomer(
      {String correo = "andresyaruro20@gmail.com"}) async {
    String url = 'https://api.mercadopago.com/v1/customers';

    DateTime now = DateTime.now();
    String fechaActual = now.toIso8601String();

    Map<String, dynamic> datosCliente = {
      "date_registered": fechaActual,
      "email": correo,
      "first_name": "Pedro",
      "last_name": "Doe",
    };

    try {
      // Realizar la solicitud POST al endpoint
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(datosCliente),
      );

      // print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode <= 205) {
        print('Cliente creado con éxito');
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String id = jsonResponse['id'];
        // print(id);
        // print('Error al crear el cliente: ${response.body}');

        return id;
      } else {
        // print('Error al crear el cliente: ${response.body}');
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> causes = jsonResponse['cause'];
        Map<String, dynamic> firstCause = causes[0];
        String errorCode = firstCause['code'];

        if (errorCode == '101') {
          return await buscarClientePorEmail(correo);
          
        }
      }

      return "error";
    } catch (error) {
      print('Error al crear el cliente: $error');
      return "error";
    }
  }

  static Future<String> buscarClientePorEmail(String email) async {
    String url = 'https://api.mercadopago.com/v1/customers/search?email=$email';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // print('Resultado de la búsqueda: $jsonResponse');
        List<dynamic> results = jsonResponse['results'];
        Map<String, dynamic> firstResult = results[0];
        String id = firstResult['id'];
        // print('ID del cliente: $id');
        return id;
      } else {
        print('Error en la búsqueda: ${response.statusCode}');
        return "error";
      }
    } catch (error) {
      print('Error en la búsqueda: $error');
      return "error";
    }
  }
}
