// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:telodigo/data/service/apimercadopago.dart';
import 'package:telodigo/domain/models/mercadopago.dart';
import 'package:telodigo/ui/components/customcomponents/credit_cards.dart';
import 'package:telodigo/ui/pages/opciones%20anfitrion/configure_card.dart';
import 'add_card.dart';

class PaymentMethod extends StatefulWidget {
  final Payer payer;
  const PaymentMethod({super.key, required this.payer});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  MercadoPago m = MercadoPago();
  MercadoTransaction mt = MercadoTransaction();
  List<CreditCard> usercards = [];
  loadCards() async {
    setState(() {
      usercards.clear();
      for (var card in widget.payer.cards) {
        usercards.add(card);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 29, 7, 48),
          foregroundColor: Colors.white,
          title: Text(
            "Tus metodos de pago",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                height: 220,
                width: 400,
                padding: EdgeInsets.only(left: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(0),
                  itemCount: usercards.length != 0 ? usercards.length : 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (usercards.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CreditCardUI(
                          num: usercards[index].numCard,
                          name: usercards[index].nameCard,
                          month: usercards[index].expireMonthCard,
                          year: usercards[index].expireYearCard,
                          method: usercards[index].paymentMethod,
                        ),
                      );
                    } else {
                      return CreditCardUI();
                    }
                  },
                ),
              ),
          
              SizedBox(height: 20,),
              Container(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      // ;
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const AddCreditCard()));
                      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ConfigureCard()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.credit_card),
                        Text("Nueva Tarjeta"),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
