import 'dart:math';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';

import '../../data/service/apimercadopago.dart';

class Payer {
  String firstName;
  String lastName;
  String email;
  String id;
  List<CreditCard> cards;
  Payer(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.id = "",
      List<CreditCard>? cards})
      : cards = cards ?? [];

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        'id': id,
      };

  mapXListCard(List<dynamic> cardslist) {
    for (var card in cardslist) {
      CreditCard itemCard = CreditCard.desdeDoc(card);
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

class CreditCard {
  String numCard;
  String nameCard;
  int expireMonthCard;
  int expireYearCard;
  int cvv;
  String idNum;
  int issuerId = 0;
  List<String> paymentsMethodId = ["debvisa", "visa", "debmaster", "master"];
  String paymentMethod = "";

  CreditCard({
    required this.numCard,
    required this.nameCard,
    required this.expireMonthCard,
    required this.expireYearCard,
    this.cvv = 0,
    this.idNum = "",
    this.issuerId = 0,
  });

  int generateRandomNumber() {
    Random random = Random();
    // Generar un número aleatorio de 10 dígitos y luego agregar un 9 al principio
    int randomNumber = random.nextInt(100000000) + 9000000000;
    return randomNumber.abs();
  }

  getPaymentMethod(int index) {
    paymentMethod = paymentsMethodId[index];
  }

  Map<String, dynamic> toJson() => {
        "card_number": numCard,
        "payment_method_id": paymentMethod,
        "cardholder": {
          "name": nameCard,
        },
        "expiration_month": expireMonthCard,
        "expiration_year": expireYearCard,
        "security_code": cvv.toString()
      };

  factory CreditCard.desdeDoc(Map<String, dynamic> data) {
    CreditCard c = CreditCard(
      numCard: data['last_four_digits'] ?? '',
      nameCard: data['cardholder']['name'] ?? '',
      expireMonthCard: data['expiration_month'] ?? '',
      expireYearCard: data['expiration_year'] ?? '',
      idNum: data['id'] ?? '',
      issuerId: data['issuer']['id'] ?? '',
    );
    c.paymentMethod = data['payment_method']['id'] ?? '';
    return c;
  }
}

class Payment {
  Payer payer;
  CreditCard card;
  double amount;
  List<CreditCard> usercards;
  String decription;
  String tokenCard;
  int installments = 1;
  String dateCreated = "";
	String dateApproved= "";
	String dateLastUpdated ="";
  Payment(
      {required this.payer,
      required this.card,
      required this.amount,
      required this.usercards,
      required this.decription,
      required this.tokenCard,
      this.installments = 1});

  Map<String, dynamic> toJson() => {
        "description": decription,
        "installments": installments,
        "payer": {"email": payer.email},
        "issuer_id": card.issuerId,
        "payment_method_id": card.paymentMethod,
        "token": tokenCard,
        "transaction_amount": amount,
      };
  
  // factory Payment.desdeDoc(Map<String, dynamic> data) {
  //   Payment p = Payment(payer: null, card:, amount: data['transaction_amount']??0, usercards: [], decription: '', tokenCard: '');
  //   c.paymentMethod = data['transaction_amount']['id'] ?? '';
  //   return p;
  //   }
}

class MercadoTransaction {
  final UserController _userController = Get.find();
  final MercadoPago m = MercadoPago();

  MercadoTransaction();

  Future getUserMercadoPago() async {
    String correo = _userController.usuario!.correo; // "jpalacio@gmail.com";
    var users = await m.searchCustomerXEmail(correo);
    late var total;
    if (users['result'] != null) {
      total = users['result']['paging']['total'];
      if (total != 0) {
        var user = users['result']['results'][0];
        Payer payer = Payer.desdeDoc(user);
        payer.mapXListCard(user['cards']);
        return {"payer": payer, "message": "operacion exitosa"};
      } else {
        return {"payer": null, "message": "Email no registrado en MercadoPago"};
      }
    } else {
      print("no encontro el email: $correo");
      return {"payer": null, "message": users['message']};
    }
  }

  Future registerUserMercadoPago() async {
    var firstName = _userController.usuario!.nombres.split(' ').length > 1
        ? _userController.usuario!.nombres.split(' ')[0]
        : _userController.usuario!.nombres;
    var lastName = _userController.usuario!.apellidos.split(' ').length > 1
        ? _userController.usuario!.apellidos.split(' ')[0]
        : _userController.usuario!.apellidos;
    var email = _userController.usuario!.correo;
    print("$firstName $lastName");
    Payer payer = Payer(firstName: firstName, lastName: lastName, email: email);
    var user = await m.createCustomer(payer.toJson());
    if (user['result'] != null) {
      return {'payer': payer, 'message': "operacion exitosa"};
    } else {
      return {'payer': null, 'message': user['message']};
    }
  }

  Future paymentTransaction(Payer payer, CreditCard card, double amount,
      List<CreditCard> usercards, String decription,
      {int installments = 1}) async {
    if (usercards.isNotEmpty) {
      if (amount != 0.0) {
        var res = await m.getCardtoken(card.toJson());
        if (res['result'] != null) {
          Payment paymentData = Payment(
              payer: payer,
              card: card,
              amount: amount,
              usercards: usercards,
              decription: decription,
              tokenCard: res['result']['id']);
              paymentData.installments = installments;
          var transaction = await m.createPayment(paymentData.toJson());
          if (transaction['result'] != null) {
            return {'payment':transaction['result'], 'message':transaction['message']};
          }else{
            return{'payment':null, 'message':transaction['message']};
          }
        } else {
          return{'payment':null, 'message':res['message']};
        }
      } else {
        return{'payment':null, 'message':"El saldo no debe ser ${amount}0"};
      }
    } else {
      return{'payment':null, 'message':"No tienes targetas registradas"};
    }
  }

}
