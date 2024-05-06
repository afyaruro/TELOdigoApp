import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/apimercadopago.dart';
import 'package:telodigo/domain/models/mercadopago.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ConfigureCard extends StatefulWidget {
  const ConfigureCard({super.key});

  @override
  State<ConfigureCard> createState() => _ConfigureCardState();
}

class _ConfigureCardState extends State<ConfigureCard> {
  final UserController _userController = Get.find();
  MercadoPago m = MercadoPago();
  MercadoTransaction mt =MercadoTransaction();
  var mfNumCard = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var mfExpireCard = MaskTextInputFormatter(
      mask: '##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var mfCodCard = MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  late TextEditingController numCard;
  late TextEditingController firstNameCard;
  late TextEditingController lastNameCard;
  late TextEditingController expireCard;
  late TextEditingController codCard;
  String _numCard = "XXXX XXXX XXXX XXXX";
  String _nameCard = "Nombre y Apellido";
  String _expireCard = "MM/YY";
  String _codCard = "XXX";
  @override
  void initState() {
    super.initState();
    numCard = TextEditingController();
    firstNameCard = TextEditingController();
    lastNameCard = TextEditingController();
    expireCard = TextEditingController();
    codCard = TextEditingController();
  }

  test() async {
    var res = await mt.getUserMercadoPago();
    print(res['payer'].id);
  }

  void onChanget(String text, TextEditingController controller) {
    setState(() {
      text = controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              "Datos de la tarjeta",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: const Alignment(0, -.6),
            child: Container(
              height: 170,
              width: MediaQuery.of(context).size.width * .65,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  alignment: const Alignment(0, 0),
                  children: [
                    Align(
                      alignment: const Alignment(-1, -1),
                      child: Image.asset("assets/sim-card.png",
                          width: 30, height: 30),
                    ),
                    Align(
                      alignment: const Alignment(-1, -0),
                      child: Text(
                        _numCard,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-1, 1),
                      child: Text(
                        _nameCard,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment(1, 1),
                      child: Text(
                        _expireCard,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: const Alignment(0, -.2),
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                height: 76,
                child: const TypeCard(),
              )),
          Align(
            alignment: const Alignment(0, .05),
            child: CustomTextField5(
              nombre: "Numero de tarjeta",
              isPassword: false,
              controller: numCard,
              height: 70,
              width: MediaQuery.of(context).size.width * .9,
              textFontSize: 12,
              placeholder: "XXXX XXXX XXXX XXXX",
              funtion: () {
                setState(() {
                  _numCard = numCard.text;
                  print(numCard.text);
                });
              },
              keyboard: TextInputType.number,
              inputFormater: [mfNumCard],
            ),
          ),
          Align(
            alignment: const Alignment(-.85, .2),
            child: CustomTextField5(
              nombre: "Nombre",
              isPassword: false,
              controller: firstNameCard,
              height: 70,
              width: MediaQuery.of(context).size.width * .42,
              textFontSize: 12,
              placeholder: "Nombre",
              funtion: () {
                setState(() {
                  _nameCard = firstNameCard.text.toUpperCase() +
                      " " +
                      lastNameCard.text.toUpperCase();
                });
              },
              keyboard: TextInputType.name,
              inputFormater: const [],
            ),
          ),
          Align(
            alignment: const Alignment(.82, .2),
            child: CustomTextField5(
              nombre: "Apellido",
              isPassword: false,
              controller: lastNameCard,
              height: 70,
              width: MediaQuery.of(context).size.width * .42,
              textFontSize: 12,
              placeholder: "Apellido",
              funtion: () {
                setState(() {
                  _nameCard = firstNameCard.text.toUpperCase() +
                      " " +
                      lastNameCard.text.toUpperCase();
                });
              },
              keyboard: TextInputType.name,
              inputFormater: const [],
            ),
          ),
          Align(
            alignment: const Alignment(-.85, .35),
            child: CustomTextField5(
              nombre: "Expiracion",
              isPassword: false,
              controller: expireCard,
              height: 70,
              width: MediaQuery.of(context).size.width * .42,
              textFontSize: 12,
              placeholder: "MM/YY",
              funtion: () {
                setState(() {
                  _expireCard = expireCard.text;
                });
              },
              keyboard: TextInputType.datetime,
              inputFormater: [mfExpireCard],
            ),
          ),
          Align(
            alignment: const Alignment(.82, .35),
            child: CustomTextField5(
              nombre: "Codigo de seguridad",
              isPassword: false,
              controller: codCard,
              height: 70,
              width: MediaQuery.of(context).size.width * .42,
              textFontSize: 12,
              placeholder: "XXX",
              funtion: () {
                setState(() {
                  _codCard = codCard.text;
                });
              },
              keyboard: TextInputType.number,
              inputFormater: [mfCodCard],
            ),
          ),
          // Align(
          //     alignment: const Alignment(0, .45),
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width * .9,
          //       child: const Row(
          //         children: [
          //           Icon(
          //             Icons.shield_outlined,
          //             color: Colors.white,
          //           ),
          //           SizedBox(
          //             width: 10,
          //           ),
          //           Text(
          //             "Cobraremos un monto aleatorio menor a 500 COP \npara validar tu tarjeta.Este sera devuelto de inmediato",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.normal),
          //           ),
          //         ],
          //       ),
          //     )),
          Align(
            alignment: const Alignment(0, .8),
            child: CustomButtonsRadius(const Color(0xffffffff),
                const Color(0xFFBEA0D1), "Guardar", true, test),
          )
        ],
      ),
    );
  }
}

class TypeCard extends StatefulWidget {
  const TypeCard({super.key});

  @override
  State<TypeCard> createState() => _TypeCardState();
}

class _TypeCardState extends State<TypeCard> {
  int _selectedIndex = -1;
  final List<List<String>> items = [
    ['Debito', "assets/visa.png"],
    ['Credito', "assets/visa.png"],
    ['Debito', "assets/master.png"],
    ['Credito', "assets/master.png"],
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 0, maxWidth: double.infinity),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          dragStartBehavior: DragStartBehavior.down,
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(items[index][1],
                          height: 40,
                          width: 40,
                          color: _selectedIndex == index
                              ? const Color(0xFFBEA0D1)
                              : Colors.white),
                      const SizedBox(height: 0),
                      Text(
                        items[index][0],
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? const Color(0xFFBEA0D1)
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
