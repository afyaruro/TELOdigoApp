// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:telodigo/data/service/apimercadopago.dart';
import 'package:telodigo/domain/models/mercadopago.dart';
import 'package:telodigo/ui/components/customcomponents/credit_cards.dart';
import 'add_card.dart';

class PaymentMethod extends StatefulWidget {
  final Payer payer;
  const PaymentMethod({ super.key, required this.payer});

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
            Align(
              alignment: const Alignment(0, -.5),
              child: Container(
                height: 220,
                width: MediaQuery.of(context).size.width*.9,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(0),
                  itemCount: usercards.length != 0 ? usercards.length : 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (usercards.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CreditCardUI(num:usercards[index].numCard,name:usercards[index].nameCard,month:  usercards[index].expireMonthCard,year:usercards[index].expireYearCard,method: usercards[index].paymentMethod,),
                      );
                    } else {
                      return CreditCardUI();
                    }
                  },
                ),
              ),
            ),

            //  ,
            //               ,
            //              ,
            //               
            Align(
              alignment: const Alignment(0, .5),
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 190, 160, 209),
                onPressed: () {;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddCreditCard()));
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xff3B2151),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
