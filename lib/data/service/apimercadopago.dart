import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
class MercadoPago {
  // String url_base;
  // final String access_token;
  // final String public_key;
  Map<String, dynamic> credentials = {};
  String token = "";
  
  MercadoPago() {
    _initialize();
  }
  Future<void> _initialize() async {
    credentials = await getCredentials();
  }

  Future<Map<String, dynamic>> getCredentials() async {
    String jsonString = await rootBundle.loadString('assets/credential.json');
    return json.decode(jsonString);
  }

  Future createCustomer(Map<String, dynamic> requestBody ) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers');
      response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': credentials['ACCESS_TOKEN'],
          },
          body: json.encode(requestBody));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future searchCustomerXEmail(String customerEmail) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers/search',
          {"email": customerEmail});
      response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': credentials['ACCESS_TOKEN'],
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future searchCustomerXId(String customerId) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers/$customerId');
      response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': credentials['ACCESS_TOKEN'],
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future updateCustomer(
      String customerId, Map<String, dynamic> requestBody) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers/$customerId');
      var response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': credentials['ACCESS_TOKEN'],
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future createCustomerCard(String customerId,String cardToken ) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers/$customerId/cards');
      response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': credentials['ACCESS_TOKEN'],
          },
          body: json.encode({"token": cardToken}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future getCustomerCards(String customerId ) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers/$customerId/cards');
      response = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': credentials['ACCESS_TOKEN'],
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future searchCustomerCard(String customerId, String cardId) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers/$customerId/cards/$cardId');
      response = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': credentials['ACCESS_TOKEN'],
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future updateCustomerCard(
      String customerId,String cardId, Map<String, dynamic> requestBody) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers/$customerId/cards/$cardId');
      var response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': credentials['ACCESS_TOKEN'],
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future deleteCustomer(
      String customerId,String cardId ) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers/$customerId/cards/$cardId');
      var response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': credentials['ACCESS_TOKEN'],
        }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future getCardtoken(Map<String, dynamic> requestBody ) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/card_tokens');
      response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': credentials['ACCESS_TOKEN'],
          },
          body: json.encode(requestBody));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body)["id"];
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future createPayment(Map<String, dynamic> requestBody) async {
    http.Response response = http.Response('', 500);
    try {
      var idempotencyKey = Uuid().v4();
      var uri = Uri.https(credentials['URL_BASE'], '/v1/payments');
      response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': credentials['ACCESS_TOKEN'],
            'X-Idempotency-Key':idempotencyKey,
          },
          body: json.encode(requestBody));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future searchInPayments() async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/payments/search');
      response = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': credentials['ACCESS_TOKEN'],
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }

  Future getPayments(String customerId, String cardId) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/customers/$customerId/cards/$cardId');
      response = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': credentials['ACCESS_TOKEN'],
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.toString(),
        "error": e.toString()
      };
    }
  }

  Future updatePayments(
      String paymentId, Map<String, dynamic> requestBody) async {
    http.Response response = http.Response('', 500);
    try {
      var uri = Uri.https(credentials['URL_BASE'], '/v1/payments/$paymentId');
      var response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': credentials['ACCESS_TOKEN'],
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return {"result": null, "message": response};
      }
    } catch (e) {
      return {
        "result": null,
        "message": response.body,
        "error": e.toString()
      };
    }
  }


}