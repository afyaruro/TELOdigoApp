import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:telodigo/data/service/apimercadopago.dart';
import '../../components/customcomponents/credit_cards.dart';
import 'add_card.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  MercadoPago m = MercadoPago();
  
  test() async {
    var res = await m.searchCustomerXEmail("");
    var res2 =res;
    print( res2[0]["cards"]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3B2151),
      body: Stack(
        alignment: const Alignment(0, 0),
        children: [
          Align(
            alignment: const Alignment(-1, -.9),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30,
                )),
          ),
          const Align(
            alignment: Alignment(-.8, -.8),
            child: Text(
              "Tus metodos de pago",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Align(
            alignment: Alignment(0, -.5),
            child: CreditCard(),
          ),
          Align(
            alignment: const Alignment(0, .5),
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 190, 160, 209),
              
              onPressed: () async {
                //var res = await m.searchCustomerXEmail("");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddCreditCard()));
                //print(res);
              },
              child: const Icon(
                Icons.add,
                color: Color(0xff3B2151),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
