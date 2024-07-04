// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/data/service/apimercadopago.dart';
import 'package:telodigo/domain/models/mercadopago.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:telodigo/data/service/peticionesPagoMP.dart';

class ConfigureCard extends StatefulWidget {
  final double saldo;
  final String id;
  final String motivo;
  final Reserva reserva;
  ConfigureCard(
      {super.key,
      required this.saldo,
      required this.id,
      required this.motivo,
      Reserva? reserva})
      : reserva = reserva ??
            Reserva(
                fechaMaximaLLegada: DateTime.now(),
                fechaFinal: DateTime.now(),
                minutoMaximoLlegada: 0,
                horaMaximaLlegada: 0,
                precio: 0,
                key: 0,
                idUserHotel: "",
                metodoPago: "",
                codigo: "",
                estado: "",
                nombreNegocio: "",
                direccion: "",
                longitud: 0,
                latitud: 0,
                fotoPrincipal: "",
                tiempoReserva: 0,
                habitacion: "",
                horaInicioReserva: 0,
                horaFinalReserva: 0,
                minutoInicioReserva: 0,
                minutoFinalReserva: 0,
                idHotel: "",
                idUser: "",
                fecha: DateTime.now(),
                nombreCliente: "");

  @override
  State<ConfigureCard> createState() => _ConfigureCardState();
}

class _ConfigureCardState extends State<ConfigureCard> {
  MercadoPago m = MercadoPago();
  MercadoTransaction mt = MercadoTransaction();

  bool isButtonDisabled = false;

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

  void onChanget(String text, TextEditingController controller) {
    setState(() {
      text = controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Datos de la tarjeta",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: 170,
              width: 400,
              margin: EdgeInsets.symmetric(horizontal: 30),
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
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              height: 76,
              // child: typeCard(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              margin: EdgeInsets.symmetric(horizontal: 20),
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
            Container(
              width: 400,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField5(
                nombre: "Nombre & apellido",
                isPassword: false,
                controller: firstNameCard,
                height: 70,
                width: MediaQuery.of(context).size.width * .42,
                textFontSize: 12,
                placeholder: "Nombre & apellido",
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
            Container(
              width: 400,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
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
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: CustomTextField5(
                      nombre: "Codigo de seguridad",
                      isPassword: true,
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
                ],
              ),
            ),
            Container(
                width: 400,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: ElevatedButton(
                  onPressed: isButtonDisabled
                      ? null
                      : () async {
                          setState(() {
                            isButtonDisabled = true;
                          });
                          if (widget.motivo == "Reserva") {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: CircularProgressIndicator(),
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text("Comprobando Dip..."),
                                    ],
                                  ),
                                );
                              },
                            );

                            if (await PeticionesReserva
                                    .comprobarDisponibilidadReserva2(
                                        idHotel: widget.reserva.idHotel,
                                        nombreHabitacion:
                                            widget.reserva.habitacion) >
                                0) {
                              Navigator.of(context).pop();
                              await PeticionesReserva
                                  .actualizarCantidadHabitacion(
                                      idHotel: widget.reserva.idHotel,
                                      nombreHabitacion:
                                          widget.reserva.habitacion,
                                      operacion: "resta");

                              await PagoDirecto.realizarPagoDirecto(
                                  reserva: widget.reserva,
                                  idNegocio: widget.id,
                                  saldo: widget.saldo,
                                  nombre: firstNameCard.text,
                                  codigo: codCard.text,
                                  context: context,
                                  motivo: widget.motivo,
                                  tarjeta: numCard.text,
                                  fecha: expireCard.text);
                            } else {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlert(
                                    title: "Lo sentimos...",
                                    text:
                                        "Unos segundos antes alguien ha reservado la última habitación disponible.",
                                  );
                                },
                              );
                            }
                          } else {
                            await PagoDirecto.realizarPagoDirecto(
                                reserva: widget.reserva,
                                idNegocio: widget.id,
                                saldo: widget.saldo,
                                nombre: firstNameCard.text,
                                codigo: codCard.text,
                                context: context,
                                motivo: widget.motivo,
                                tarjeta: numCard.text,
                                fecha: expireCard.text);
                          }
                          setState(() {
                            isButtonDisabled = false;
                          });
                        },
                  child: Text(
                    "CONFIRMAR",
                    style: TextStyle(
                        color: isButtonDisabled
                            ? Colors.white
                            : Color.fromARGB(255, 47, 4, 73)),
                  ),
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Color.fromARGB(125, 52, 2, 92),
                      backgroundColor: const Color(0xffffffff)),
                )),
            // CustomButtonsRadiusx(const Color(0xffffffff),
            //     Color.fromARGB(255, 47, 4, 73), "CONFIRMAR", () async {

            // }),
          ],
        ),
      ),
    );
  }
}
