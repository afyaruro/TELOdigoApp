import 'package:flutter/material.dart';
import 'package:telodigo/ui/pages/opciones%20anfitrion/configure_card.dart';


class AddCreditCard extends StatefulWidget {
  const AddCreditCard({super.key});

  @override
  State<AddCreditCard> createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
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
              "Selecciona el metodo de pago",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Align(
            alignment: Alignment(0, -.55),
            child: MethodOpction(),
          ),
        ],
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
      width: MediaQuery.of(context).size.width * .9,
      height: 200,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 156, 110, 187),
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
                  const Text(
                    "Credito o debito (Con CVV)",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              const Divider(
                thickness: 1.5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/master.png", width: 40, height: 40),
                  const SizedBox(
                    width: 25,
                  ),
                  Image.asset("assets/visa.png", width: 40, height: 40),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
