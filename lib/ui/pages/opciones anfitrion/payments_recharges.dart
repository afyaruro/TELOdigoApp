// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:telodigo/data/service/apimercadopago.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/mercadopago.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/pages/anuncios%20anfitrion/anunciosanfitrion.dart';
import 'package:telodigo/ui/pages/opciones%20anfitrion/payment_method.dart';

int selectedIndex = 0;

class PaymentsRecharges extends StatefulWidget {
  Payer payer;
  List<Hoteles> listhotels;
  PaymentsRecharges({required this.payer, required this.listhotels, super.key});

  @override
  State<PaymentsRecharges> createState() => _PaymentsRechargesState();
}

class _PaymentsRechargesState extends State<PaymentsRecharges> {
  MercadoPago m = MercadoPago();
  MercadoTransaction mt = MercadoTransaction();
  late MoneyMaskedTextController saldo;
  List<Habitaciones> listRooms = [];
  List<String> listHotelName = [];
  List<CreditCard> usercards = [];
  final ScrollController _controller = ScrollController();
  int _selectedIndex = 0;
  String selectedItemText = "";
  loadCards() async {
    setState(() {
      usercards.clear();
      for (var card in widget.payer.cards) {
        usercards.add(card);
      }
    });
  }

  loadRooms() {
    for (var hotel in widget.listhotels) {
      listHotelName.add(hotel.nombre);
      print("hotel:${hotel.nombre}");
      //print("N° habitaciones:${hotel.habitaciones.length}");
      for (var habitacion in hotel.habitaciones) {
        listRooms.add(habitacion);
        //print("tipo: ${habitacion.nombre}");
        //print("N° precio: ${habitacion.precios.length}");
      }
    }
    print(listHotelName.length);
    setState(() {});
  }


  final String publicKey = 'TEST-085f6aba-bb3c-421c-b4de-77ffb91907e1';
final String accessToken = 'TEST-1713151696136887-051023-0478d28c52ce72c8df33ea839002ebf8-415512808';

  @override
  void initState() {
    super.initState();
    loadCards();
    _controller.addListener(_onScroll);
    saldo = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      leftSymbol: 'S/ ',
    );
    saldo.text = "S/0.00";
    loadRooms();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    final items = _controller.position.maxScrollExtent /
        (usercards.length - 1); // Ajusta el valor para adaptarlo a tu lista
    final index = (_controller.offset / items).round();
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void getDropDownIndexText(String? newValue) {
    if (newValue != null) {
      // Actualizar el valor seleccionado cuando cambia
      print(newValue);
      // Llamar a setState para que Flutter repinte el widget
      setState(() {
        selectedItemText = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
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
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              const Align(
                alignment: Alignment(-.8, -.78),
                child: Text(
                  "Recargas",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment(0, -.34),
                child: Text(
                  "Monto",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: const Alignment(0, -.55),
                child: CustomTextField6(
                    controller: saldo,
                    height: 100,
                    width: MediaQuery.of(context).size.width * .6,
                    textFontSize: 35,
                    funtion: () {},
                    keyboard: TextInputType.number),
              ),
              Align(
                  alignment: const Alignment(0, -.175),
                  child: listHotelName.isEmpty
                      ? NoDropDownItem("Sin Hoteles")
                      : listHotelName.length<2? NoDropDownItem(listHotelName[0]) :CustomComboBoxbutton3(
                          data:listHotelName,
                          initText: selectedItemText,
                          height: 60,
                          width: MediaQuery.of(context).size.width * .7,
                          fontSize: 22,
                          getDropDownIndex: getDropDownIndexText,
                        )),
              const Align(
                alignment: Alignment(0, -.05),
                child: Text(
                  "Seleccione su hotel",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                  alignment: const Alignment(0, .225),
                  child: CreditCardSelector(
                    cards: usercards,
                    controller: _controller,
                    payer: widget.payer,
                  )),
              const Align(
                alignment: Alignment(0, .380),
                child: Text(
                  "Seleccione su Metodo de pago",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: const Alignment(0, .8),
                child: CustomButtonsRadius5(
                    const Color(0xffffffff),
                    const Color(0xFFBEA0D1),
                    "Pagar",
                    true,
                    PaymentRecharge,
                    300.0,
                    70.0,
                    22.0),
              )

              // Align(
              //   alignment: const Alignment(0, .8),
              //   child: CustomButtonsRadiusx(
              //       const Color(0xffffffff),
              //       const Color(0xFFBEA0D1),
              //       "Pagar",
              //       (){
                      

              //       },
              //       ),
              // )
            ],
          ),
        ));
  }
















  PaymentRecharge() async {
    CreditCard card = usercards[_selectedIndex];
    String description = "regarga telodigo-app a $selectedItemText";
    

    var result = await mt.paymentTransaction(
        widget.payer, card, saldo.numberValue, usercards, description);
        print(result["message"]);
    // if (result['payment'] != null) {
    //   print(result['payment']);
    // } else {
    //   print(result['message']);
    // }
  }

  NoDropDownItem(String titulo) {
    return GestureDetector(
      onTap: () {
        if (listHotelName.isEmpty){

         Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AnunciosAnfitrion()));
        }else{
          loadRooms();
          setState(() {
            
          });
        }
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * .7,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(60 / 4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
                size: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreditCardSelector extends StatefulWidget {
  List<CreditCard> cards;
  ScrollController controller;
  Payer payer;
  CreditCardSelector({
    required this.cards,
    required this.controller,
    required this.payer,
    super.key,
  });

  @override
  State<CreditCardSelector> createState() => _CreditCardSelectorState();
}

class _CreditCardSelectorState extends State<CreditCardSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      height: 120,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent),
      child: ListView.builder(
        itemExtent: widget.cards.isEmpty ? 240 : 260,
        controller: widget.controller,
        padding: widget.cards.isEmpty
            ? const EdgeInsets.all(15)
            : const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        scrollDirection: Axis.horizontal,
        itemCount: widget.cards.isEmpty ? 1 : widget.cards.length,
        itemBuilder: (BuildContext context, int index) {
          return widget.cards.isEmpty
              ? NoCards(
                  payer: widget.payer,
                )
              : CreditCardItem(
                  index: index,
                  num: widget.cards[index].numCard,
                  method: widget.cards[index].paymentMethod,
                  length: widget.cards.length,
                );
        },
      ),
    );
  }
}

class NoCards extends StatelessWidget {
  Payer payer;
  NoCards({
    required this.payer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentMethod(payer: payer)));
      },
      child: const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            "Sin Tarjetas",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class CreditCardItem extends StatefulWidget {
  const CreditCardItem({
    super.key,
    required this.index,
    required this.num,
    required this.method,
    required this.length,
  });
  final int index;
  final String num;
  final String method;
  final int length;
  @override
  State<CreditCardItem> createState() => _CreditCardItemState();
}

class _CreditCardItemState extends State<CreditCardItem> {
  final List<List<String>> images = [
    ['debvisa', "assets/visa.png", "60", "60"],
    ['visa', "assets/visa.png", "60", "60"],
    ['debmaster', "assets/master.png", "50", "50"],
    ['master', "assets/master.png", "50", "50"],
  ];
  final List<List<dynamic>> alignCardName = [
    ['debvisa', const Alignment(.25, -.4)],
    ['visa', const Alignment(.25, -.4)],
    ['debmaster', const Alignment(.2, -.5)],
    ['master', const Alignment(.2, -.5)],
  ];
  final List<List<String>> typeCardName = [
    ['debvisa', "Tarjeta Debito"],
    ['visa', "Tarjeta Credito"],
    ['debmaster', "Tarjeta Debito"],
    ['master', "Tarjeta Credito"],
  ];
  String selectTypeCardName() {
    for (var name in typeCardName) {
      if (name[0] == widget.method) {
        return name[1];
      }
    }
    return "";
  }

  String selectWidth() {
    for (var name in images) {
      if (name[0] == widget.method) {
        return name[2];
      }
    }
    return "";
  }

  String selectHeight() {
    for (var name in images) {
      if (name[0] == widget.method) {
        return name[3];
      }
    }
    return "";
  }

  String imageIcon() {
    for (var icon in images) {
      if (icon[0] == widget.method) {
        return icon[1];
      }
    }
    return "";
  }

  selectAling() {
    for (var name in alignCardName) {
      if (name[0] == widget.method) {
        return name[1];
      }
    }
    return "";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        width: 242,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 156, 110, 187),
            borderRadius: BorderRadius.circular(5)),
        child: Stack(
          alignment: const Alignment(0, 0),
          children: [
            Visibility(
              visible: widget.length > 1
                  ? widget.index < widget.length - 1
                      ? true
                      : false
                  : false,
              child: const Align(
                  alignment: Alignment(1, 0),
                  child: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.white,
                  )),
            ),
            Visibility(
              visible: widget.length > 1
                  ? widget.index < widget.length - 1
                      ? false
                      : true
                  : false, //indexOfLastElemnt(widget.index),
              child: const Align(
                  alignment: Alignment(-1, 0),
                  child: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.white,
                  )),
            ),
            Align(
              alignment: const Alignment(-.65, -1),
              child: Image.asset(
                imageIcon(),
                height: double.parse(selectHeight()),
                width: double.parse(selectWidth()),
                color: Colors.white,
              ),
            ),
            Align(
              alignment: selectAling(),
              child: Text(
                selectTypeCardName(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: const Alignment(0, .5),
              child: Text(
                "XXXX XXXX XXXX ${widget.num}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
