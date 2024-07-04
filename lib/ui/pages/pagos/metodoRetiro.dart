import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/peticionesPagoMP.dart';
import 'package:telodigo/data/service/peticionesSolicitudPago.dart';
import 'package:telodigo/domain/models/solicitdPago.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/pages/pagos/gestionarPagos.dart';

class MetodoRetiro extends StatefulWidget {
  final double saldo;
  const MetodoRetiro({super.key, required this.saldo});

  @override
  State<MetodoRetiro> createState() => _MetodoRetiroState();
}

class _MetodoRetiroState extends State<MetodoRetiro> {
  TextEditingController controllerTipoCuenta =
      TextEditingController(text: "Cuenta de ahorros");
  TextEditingController controllerNumeroCuenta =
      TextEditingController(text: "");
  TextEditingController controllerTitularCuenta =
      TextEditingController(text: "");
  TextEditingController controllerNumeroContacto =
      TextEditingController(text: "");
  static final UserController controlleruser = Get.find();
  bool isButtonDisabled = false;

  List<String> listBancos = [
    "BCP",
    "INTERBANK",
    "YAPE",
    "PLIN",
  ];
  String selectedBanco = "BCP";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Coloca tu método de pago para comenzar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Banco",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 200,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(20),
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white),
                              iconEnabledColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              style: const TextStyle(color: Colors.white),
                              value: selectedBanco,
                              dropdownColor:
                                  const Color.fromARGB(255, 108, 108, 150),
                              isExpanded: true,
                              items: listBancos.map((banco) {
                                return DropdownMenuItem(
                                  value: banco,
                                  child: Center(child: Text(banco)),
                                );
                              }).toList(),
                              onChanged: (String? selectedBnco) {
                                setState(() {
                                  selectedBanco = selectedBnco!;
                                  controllerNumeroCuenta.text = "";
                                  controllerNumeroContacto.text = "";
                                  controllerTitularCuenta.text = "";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      selectedBanco == "YAPE" || selectedBanco == "PLIN"
                          ? IsYapePlin(
                              celular: controllerNumeroCuenta,
                              numeroContacto: controllerNumeroContacto,
                              titularCuenta: controllerTitularCuenta,
                            )
                          : IsBanco(
                              titularCuenta: controllerTitularCuenta,
                              numeroCuenta: controllerNumeroCuenta,
                              numeroContacto: controllerNumeroContacto,
                              seledtedCuenta: controllerTipoCuenta,
                              banco: selectedBanco,
                            ),
                      Center(
                        child: Container(
                            width: 250,
                            child: const Text(
                              textAlign: TextAlign.center,
                              "El pago será efectivo en un plazo máximo de 72 horas",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 192, 174, 212)),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: ElevatedButton(
                        onPressed: isButtonDisabled
                            ? null
                            : () async {
                                setState(() {
                                  isButtonDisabled = true;
                                });
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                          Text("Solicitando..."),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                if (controllerNumeroCuenta.text.isEmpty ||
                                    controllerTitularCuenta.text.isEmpty ||
                                    controllerTipoCuenta.text.isEmpty ||
                                    controllerNumeroContacto.text.isEmpty ||
                                    selectedBanco.isEmpty) {
                                  mostrarAlertaExito(
                                      funcion: () {
                                        Navigator.of(context).pop();
                                      },
                                      color: const Color.fromARGB(
                                          255, 216, 10, 10),
                                      icon: Icons.error,
                                      context: context,
                                      title: "Validar Campos",
                                      mensaje:
                                          "Comprueba que haz llenado todos los campos",
                                      monto: double.parse(
                                          widget.saldo.toString()));
                                } else if (controllerNumeroCuenta.text.length ==
                                            13 &&
                                        selectedBanco == "INTERBANK" ||
                                    controllerTipoCuenta.text ==
                                            "Cuenta de ahorros" &&
                                        selectedBanco == "BCP" &&
                                        controllerNumeroCuenta.text.length ==
                                            14 ||
                                    controllerTipoCuenta.text ==
                                            "Cuenta corriente" &&
                                        selectedBanco == "BCP" &&
                                        controllerNumeroCuenta.text.length ==
                                            13 ||
                                    selectedBanco == "YAPE" &&
                                        controllerNumeroCuenta.text.length ==
                                            11 ||
                                    selectedBanco == "PLIN" &&
                                        controllerNumeroCuenta.text.length ==
                                            11) {
                                  //registrar

                                  final CollectionReference collection =
                                      FirebaseFirestore.instance
                                          .collection("Pagos");
                                  var solicitudCont = (await collection
                                          .where('userAnfitrion',
                                              isEqualTo: controlleruser
                                                  .usuario!.userName)
                                          .get())
                                      .size;
                                  SolicitudPago solicitud = SolicitudPago(
                                    fecha: DateTime.now(),
                                    userAnfitrion:
                                        controlleruser.usuario!.userName,
                                    banco: selectedBanco,
                                    celularContacto:
                                        controllerNumeroContacto.text,
                                    nombreTitular: controllerTitularCuenta.text,
                                    monto: widget.saldo,
                                    numeroCuenta: controllerNumeroCuenta.text,
                                    concepto: "Retiro",
                                    motivo: "",
                                    estado: "En espera",
                                    id: "${controlleruser.usuario!.userName}$solicitudCont",
                                  );

                                  QuerySnapshot querySnapshot =
                                      await FirebaseFirestore.instance
                                          .collection("Usuarios")
                                          .where('userName',
                                              isEqualTo:
                                                  solicitud.userAnfitrion)
                                          .get();

                                  if (querySnapshot.docs.isNotEmpty) {
                                    DocumentSnapshot document =
                                        querySnapshot.docs.first;
                                    double saldoActual =
                                        document['saldoCuenta'];

                                    if (saldoActual >= solicitud.monto) {
                                      await PeticionesSolicitudPago
                                          .nuevaSolicitudPago(
                                              solicitud, context);
                                    } else {
                                      mostrarAlertaExito(
                                          funcion: () {
                                            Navigator.of(context).pop();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SolicitarPagos()),
                                              (Route<dynamic> route) => false,
                                            );
                                          },
                                          color: const Color.fromARGB(
                                              255, 216, 10, 10),
                                          icon: Icons.error,
                                          context: context,
                                          title: "Saldo Insuficiente",
                                          mensaje:
                                              "El saldo de tu cuenta es insuficiente ya que tu saldo actual $saldoActual es menor que el monto solicitado ${solicitud.monto}",
                                          monto: double.parse(
                                              widget.saldo.toString()));
                                    }
                                  }
                                } else if (selectedBanco == "YAPE" &&
                                        controllerNumeroCuenta.text.length <
                                            11 ||
                                    selectedBanco == "PLIN" &&
                                        controllerNumeroCuenta.text.length <
                                            11) {
                                  mostrarAlertaExito(
                                      funcion: () {
                                        Navigator.of(context).pop();
                                      },
                                      color: const Color.fromARGB(
                                          255, 216, 10, 10),
                                      icon: Icons.error,
                                      context: context,
                                      title: "Valida tu Cuenta",
                                      mensaje:
                                          "Tu numero de celular no cumple con el formato de una cuenta de YAPE o PLIN",
                                      monto: double.parse(
                                          widget.saldo.toString()));
                                } else {
                                  mostrarAlertaExito(
                                      funcion: () {
                                        Navigator.of(context).pop();
                                      },
                                      color: const Color.fromARGB(
                                          255, 216, 10, 10),
                                      icon: Icons.error,
                                      context: context,
                                      title: "Validar Cuenta",
                                      mensaje:
                                          "Por favor verifica que tu numero de cuenta cumpla con el formato",
                                      monto: double.parse(
                                          widget.saldo.toString()));
                                }
                                setState(() {
                                  isButtonDisabled = false;
                                });
                              },
                        child: Text("CONFIRMAR",
                            style: TextStyle(
                                color: isButtonDisabled
                                    ? Colors.white
                                    : Color.fromARGB(255, 47, 4, 73))),
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor:
                                Color.fromARGB(125, 52, 2, 92),
                            backgroundColor: const Color(0xffffffff)),
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IsBanco extends StatefulWidget {
  final TextEditingController seledtedCuenta;
  final TextEditingController numeroCuenta;
  final TextEditingController titularCuenta;
  final TextEditingController numeroContacto;
  final String banco;

  const IsBanco(
      {super.key,
      required this.seledtedCuenta,
      required this.numeroCuenta,
      required this.titularCuenta,
      required this.numeroContacto,
      required this.banco});

  @override
  State<IsBanco> createState() => _IsBancoState();
}

class _IsBancoState extends State<IsBanco> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 400,
          child: const Text(
            "Seleccione el tipo de cuenta",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: 400,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(20),
                icon:
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                iconEnabledColor: const Color.fromARGB(255, 255, 255, 255),
                style: const TextStyle(color: Colors.white),
                value: widget.seledtedCuenta.text,
                dropdownColor: const Color.fromARGB(255, 108, 108, 150),
                isExpanded: true,
                items: ["Cuenta de ahorros", "Cuenta corriente"].map((banco) {
                  return DropdownMenuItem(
                    value: banco,
                    child: Center(child: Text(banco)),
                  );
                }).toList(),
                onChanged: (String? cuenta) {
                  setState(() {
                    widget.seledtedCuenta.text = cuenta!;
                    widget.numeroCuenta.text = "";
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        widget.seledtedCuenta.text == "Cuenta de ahorros" &&
                widget.banco == "BCP"
            ? CustomTextFieldCuenta(
                controller: widget.numeroCuenta,
                function: () {},
                height: 70,
                isPassword: false,
                nombre: "N° cuenta",
                placeholder: "XXXXXXXXXXXXXX",
                textFontSize: 12,
                width: 400,
                keyboard: TextInputType.number,
                inputFormatters: [],
                maxLength: 14,
              )
            : CustomTextFieldCuenta(
                controller: widget.numeroCuenta,
                function: () {},
                height: 70,
                isPassword: false,
                nombre: "N° cuenta",
                placeholder: "XXXXXXXXXXXXX",
                textFontSize: 12,
                width: 400,
                keyboard: TextInputType.number,
                inputFormatters: [],
                maxLength: 13,
              ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 400,
          child: CustomTextField5(
            nombre: "Titular de la cuenta",
            isPassword: false,
            controller: widget.titularCuenta,
            height: 70,
            width: MediaQuery.of(context).size.width * .42,
            textFontSize: 12,
            placeholder: "Nombre del titular de la cuenta",
            funtion: () {},
            keyboard: TextInputType.name,
            inputFormater: const [],
          ),
        ),
        Container(
          width: 400,
          child: CustomTextField5(
            nombre: "Celular de contacto",
            isPassword: false,
            controller: widget.numeroContacto,
            height: 70,
            width: MediaQuery.of(context).size.width * .42,
            textFontSize: 12,
            placeholder: "Celular de contacto",
            funtion: () {},
            keyboard: TextInputType.number,
            inputFormater: const [],
          ),
        ),
      ],
    );
  }
}

class IsYapePlin extends StatefulWidget {
  final TextEditingController celular;
  final TextEditingController titularCuenta;
  final TextEditingController numeroContacto;
  const IsYapePlin(
      {super.key,
      required this.celular,
      required this.titularCuenta,
      required this.numeroContacto});

  @override
  State<IsYapePlin> createState() => _IsYapePlinState();
}

class _IsYapePlinState extends State<IsYapePlin> {
  var formNumCuenta = MaskTextInputFormatter(
      mask: '### ### ###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 400,
          child: CustomTextField5(
            nombre: "N° celular",
            isPassword: false,
            controller: widget.celular,
            height: 70,
            width: MediaQuery.of(context).size.width * .42,
            textFontSize: 12,
            placeholder: "XXX XXX XXX",
            funtion: () {},
            keyboard: TextInputType.number,
            inputFormater: [formNumCuenta],
          ),
        ),
        Container(
          width: 400,
          child: CustomTextField5(
            nombre: "Nombre titular",
            isPassword: false,
            controller: widget.titularCuenta,
            height: 70,
            width: MediaQuery.of(context).size.width * .42,
            textFontSize: 12,
            placeholder: "Nombre titular",
            funtion: () {},
            keyboard: TextInputType.name,
            inputFormater: const [],
          ),
        ),
        Container(
          width: 400,
          child: CustomTextField5(
            nombre: "Celular de contacto",
            isPassword: false,
            controller: widget.numeroContacto,
            height: 70,
            width: MediaQuery.of(context).size.width * .42,
            textFontSize: 12,
            placeholder: "Celular de contacto",
            funtion: () {},
            keyboard: TextInputType.number,
            inputFormater: const [],
          ),
        )
      ],
    );
  }
}

class CustomTextFieldCuenta extends StatefulWidget {
  final String nombre;
  final bool isPassword;
  final TextEditingController controller;
  final double height;
  final double width;
  final double textFontSize;
  final String placeholder;
  final VoidCallback function;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboard;
  final int maxLength; // Added to limit character count

  const CustomTextFieldCuenta({
    super.key,
    required this.nombre,
    required this.isPassword,
    required this.controller,
    required this.height,
    required this.width,
    required this.textFontSize,
    required this.placeholder,
    required this.function,
    required this.inputFormatters,
    required this.keyboard,
    this.maxLength = 13, // Set default max length, adjust as needed
  });

  @override
  _CustomTextFieldCuentaState createState() => _CustomTextFieldCuentaState();
}

class _CustomTextFieldCuentaState extends State<CustomTextFieldCuenta> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextField(
        onChanged: (text) {
          // Limit input length here (optional, explained below)
          if (text.length > widget.maxLength) {
            widget.controller.text = text.substring(0, widget.maxLength);
          }
          setState(() {
            widget.function();
          });
        },
        keyboardType: widget.keyboard,
        inputFormatters: [
          ...widget.inputFormatters, // Combine existing formatters
          FilteringTextInputFormatter.allow(
              RegExp(r'[0-9]')), // Allow only numbers
        ],
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: widget.isPassword ? _obscureText : false,
        maxLength: widget.maxLength, // Set max length in TextField
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            hintText: widget.placeholder,
            hintStyle:
                TextStyle(color: Colors.white, fontSize: widget.textFontSize),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.height / 4),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.height / 4),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.height / 4),
              borderSide: const BorderSide(color: Colors.white),
            ),
            labelText: widget.nombre,
            labelStyle:
                TextStyle(color: Colors.white, fontSize: widget.textFontSize),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      size: 20,
                    ),
                    color: Colors.white,
                  )
                : null,
            counterStyle: const TextStyle(color: Colors.white)),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
