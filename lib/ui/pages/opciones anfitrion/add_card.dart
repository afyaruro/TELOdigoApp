// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:telodigo/ui/pages/opciones%20anfitrion/configure_card.dart';

//no use

class AddCreditCard extends StatefulWidget {
  const AddCreditCard({super.key});

  @override
  State<AddCreditCard> createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Selecciona el metodo de pago",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 29, 7, 48),
        ),
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        body: MethodOpction(),
      ),
    );
  }
}

class MethodOpction extends StatelessWidget {
  const MethodOpction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 150,
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 69, 24, 99),
          borderRadius: BorderRadius.circular(35)),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ConfigureCard()));
        },
        borderRadius: BorderRadius.circular(35),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Icon(
                      Icons.add_card_rounded,
                      color: Color(0xff3B2151),
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Flexible(
                    child: const Text(
                      "Credito o debito (Con CVV)",
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              // const Divider(
              //   thickness: 1.5,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Image.asset("assets/master.png", width: 40, height: 40),
              //     const SizedBox(
              //       width: 25,
              //     ),
              //     Image.asset("assets/visa.png", width: 40, height: 40),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
