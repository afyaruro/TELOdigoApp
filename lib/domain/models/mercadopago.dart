import 'dart:math';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';

import '../../data/service/apimercadopago.dart';

class Payer {
  String firstName;
  String lastName;
  String email;
  String id;
  List<Card> cards;
  Payer(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.id = "",
      List<Card>? cards}):cards=cards ?? [] ;

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        'id': id,
      };

  mapXListCard(List<dynamic> cardslist) {
    for (var card in cardslist) {
      Card itemCard = Card.desdeDoc(card);
      cards.add(itemCard);
    }
  }

  factory Payer.desdeDoc(Map<String, dynamic> data) {
    return Payer(
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      email: data['email'] ?? '',
      id: data['id'] ?? '',
    );
  }
}

class Card {
  String numCard;
  String nameCard;
  int expireMonthCard;
  int expireYearCard;
  int cvv;
  String idNum;
  int issuerId = 0;
  List<String> paymentsMethodId = ["debvisa", "visa", "debmaster", "master"];
  String paymentMethod = "";

  Card(
      {required this.numCard,
      required this.nameCard,
      required this.expireMonthCard,
      required this.expireYearCard,
      required this.cvv,
      this.idNum = "",
      this.issuerId = 0});
  int generateRandomNumber() {
    Random random = Random();
    // Generar un número aleatorio de 11 dígitos
    int randomNumber = random.nextInt(99999999999 - 10000000000) + 10000000000;
    return randomNumber;
  }

  getPaymentMethod(int index) {
    paymentMethod = paymentsMethodId[index];
  }

  Map<String, dynamic> toJson() => {
        "card_number": numCard,
        "payment_method_id": paymentMethod,
        "cardholder": {
          "name": nameCard,
          "identification": {
            "number": idNum,
            "type": "CPF"
          }
        },
        "expiration_month": expireMonthCard,
        "expiration_year": expireYearCard,
        "security_code": cvv
      };

  factory Card.desdeDoc(Map<String, dynamic> data) {
    return Card(
      numCard: data['last_four_digits'] ?? '',
      nameCard: data['cardholder']['name'] ?? '',
      expireMonthCard: data['expiration_month'] ?? '',
      expireYearCard: data['expiration_year'] ?? '',
      idNum: data['id'] ?? '',
      issuerId: data['issuer']['id'] ?? '',
      cvv: 0,
    );
  }
}

class Payment {
  Map<String, dynamic> toJson() => {
        "description": "regarga telodigo-app",
        "installments": 1,
        "payer": {"email": "jpalacio@gmail.com"},
        "issuer_id": 204,
        "payment_method_id": "master",
        "token": "",
        "transaction_amount": 5987.230
      };
}

class MercadoTransaction{
  final UserController _userController = Get.find();
  final MercadoPago m = MercadoPago();

  MercadoTransaction();

  Future getUserMercadoPago() async {
    var correo = _userController.usuario!.correo;
    var users = await m.searchCustomerXEmail(correo);
    late var total;
    if (users['result'] != null){
      total =users['result']['paging']['total'];
      if (total!=0){
        var user = users['result']['results'][0];
        Payer payer = Payer.desdeDoc(user);
        payer.mapXListCard(user['cards']);
        return {"payer": payer, "message": "operacion exitosa"};
      }else{
        return {"payer": null, "message": "Email no registrado en MercadoPago"};
      }
    }else{  
      print("no encontro el email");
      return {"payer": null, "message": users['message']};
    
    }
  }

  Future registerUserMercadoPago() async {
      var firstName =_userController.usuario!.nombres.split(' ')[0];
      var lastName =_userController.usuario!.apellidos.split(' ')[0];
      var email = _userController.usuario!.correo;
      Payer payer  =Payer(firstName: firstName, lastName: lastName, email: email);
      var user = await m.createCustomer(payer.toJson());
      if(user['result']!=null){
        return {'payer': payer, 'message': "operacion exitosa"};
      }else{
        return {'payer': null, 'message':user['message'] };
      }
  }

  
}