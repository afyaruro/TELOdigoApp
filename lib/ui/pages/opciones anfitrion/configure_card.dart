// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:telodigo/data/service/apimercadopago.dart';
import 'package:telodigo/domain/models/mercadopago.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:telodigo/ui/pages/opciones%20anfitrion/payment_method.dart';

class ConfigureCard extends StatefulWidget {
  const ConfigureCard({super.key});

  @override
  State<ConfigureCard> createState() => _ConfigureCardState();
}

class _ConfigureCardState extends State<ConfigureCard> {
  MercadoPago m = MercadoPago();
  MercadoTransaction mt = MercadoTransaction();
  int _selectedIndex = -1;
  bool _itemTap = false;
  final List<List<String>> items = [
    ['Debito', "assets/visa.png"],
    ['Credito', "assets/visa.png"],
    ['Debito', "assets/master.png"],
    ['Credito', "assets/master.png"],
  ];
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
    print(_selectedIndex);
    numCard = TextEditingController();
    firstNameCard = TextEditingController();
    lastNameCard = TextEditingController();
    expireCard = TextEditingController();
    codCard = TextEditingController();
  }

  bool validateSelection() {
    print(_selectedIndex);
    if (_selectedIndex != -1) {
      return false;
    } else {
      return true;
    }
  }

  bool isAnyFieldEmpty() {
    // Verifica si algún campo está vacío
    print(numCard.text.isEmpty);
    if (validateSelection() &&
        numCard.text.isEmpty &&
        firstNameCard.text.isEmpty &&
        lastNameCard.text.isEmpty &&
        expireCard.text.isEmpty &&
        codCard.text.isEmpty) {
      return true;
    } else {
      print("Todos los campos llenos");
      return false;
    }
  }

  String removeCharacter(String inputString, String charToRemove) {
    return inputString.replaceAll(charToRemove, '');
  }

  int completeYear(int lastTwoDigits) {
    // Obteniendo el año actual
    int currentYear = DateTime.now().year;
    // Obteniendo los dos últimos dígitos del año actual
    int lastTwoDigitsCurrentYear = currentYear % 100;
    // Calculando el nuevo año completando los dos últimos dígitos
    int completedYear = currentYear - lastTwoDigitsCurrentYear + lastTwoDigits;
    return completedYear;
  }

  tapOverrideItem(
    int index,
  ) {
    if (index == _selectedIndex) {
      _itemTap = true;
    } else {
      _itemTap = false;
    }
  }

  saveCard() async {
    bool validator = isAnyFieldEmpty();
    if (validator) {
      ///---------------Alerta de caampos vacions---------///
      print("Alerta de campos vacios");
    } else {
      CreditCard card = CreditCard(
        numCard: removeCharacter(_numCard, " "),
        nameCard: _nameCard,
        expireMonthCard: int.parse(_expireCard.split('/')[0]),
        expireYearCard: completeYear(int.parse(_expireCard.split('/')[1])),
        cvv: int.parse(_codCard),
      );
      card.getPaymentMethod(_selectedIndex);
      print(card.toJson());
      var tokenCard = await m.getCardtoken(card.toJson());
      if (tokenCard['result'] != null) {
        var payer = await mt.getUserMercadoPago();
        if (payer['payer'] != null) {
          var result = await m.createCustomerCard(
              payer['payer'].id, tokenCard['result']['id']);
          if (result['result'] != null) {
            var payer = await mt.getUserMercadoPago();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentMethod(payer: payer['payer'],)));
          }
          else{
            ///---------------Alerta de error al añadir la targeta---------///
            print("Alerta de error al añadir la targeta");
            print(result['message']);
          }
        } else {
          ///---------------Alerta de error al obtener el usuario---------///
          print("Alerta de error al obtener el usuario");
          print(payer['message']);
        }
      } else {
        ///---------------Alerta de error al generar el token card---------///
        print("Alerta de error al generar el token card");
        print(tokenCard['message']);
      }
    }
  }

  void onChanget(String text, TextEditingController controller) {
    setState(() {
      text = controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff3B2151),
        body: Stack(
          alignment: const Alignment(0, 0),
          children: [
            Align(
              alignment: const Alignment(-1, -.9),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
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
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
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
                        alignment: const Alignment(-1, 1),
                        child: Text(
                          _nameCard,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(1, 1),
                        child: Text(
                          _expireCard,
                          style: const TextStyle(
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 76,
                  child: typeCard(),
                )
              ),
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
                    _nameCard =
                        "${firstNameCard.text.toUpperCase()} ${lastNameCard.text.toUpperCase()}";
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
                    _nameCard =
                        "${firstNameCard.text.toUpperCase()} ${lastNameCard.text.toUpperCase()}";
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
              child: CustomButtonsRadius4(const Color(0xffffffff),
                  const Color(0xFFBEA0D1), "Guardar", true, saveCard),
            )
          ],
        ),
      ),
    );
  }

  Container typeCard() {
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
                    tapOverrideItem(index);
                    if (_itemTap) {
                      _selectedIndex = -1;
                      print("tap override index $index");
                    } else {
                      _selectedIndex = index;
                      print("tap on index $index");
                    }
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
