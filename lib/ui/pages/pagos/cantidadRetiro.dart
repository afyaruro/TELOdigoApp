import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/pages/pagos/metodoRetiro.dart';
import 'package:telodigo/data/service/peticionesPagoMP.dart';

class CantidadRetiro extends StatefulWidget {
  final double saldoCuenta;
  const CantidadRetiro({super.key, required this.saldoCuenta});

  @override
  State<CantidadRetiro> createState() => _CantidadRetiroState();
}

class _CantidadRetiroState extends State<CantidadRetiro> {
  TextEditingController saldo = TextEditingController(text: "");
  // List<Hoteles> hoteles = [];
  int selectedNegocio = 1;

  @override
  void initState() {
    super.initState();
    saldo = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      leftSymbol: 'S/ ',
    );
    saldo.text = "S/0.00";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Retirar Dinero",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 29, 7, 48),
        ),
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromARGB(0, 170, 166, 154),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                CustomTextField6(
                    controller: saldo,
                    height: 100,
                    width: 220,
                    textFontSize: 35,
                    keyboard: TextInputType.number),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      String variable = saldo.text;
                      String numeros =
                          variable.replaceAll(RegExp(r"[^\d\,.]"), "");
                      numeros = numeros.replaceAll(".", "");
                      String saldoRetiro = numeros.replaceAll(",", ".");
                      // print(saldo.text);
                      if (double.parse(saldoRetiro) == 0.0) {
                        mostrarAlertaExito(
                            funcion: () {
                              Navigator.of(context).pop();
                            },
                            color: Color.fromARGB(255, 216, 10, 10),
                            icon: Icons.attach_money,
                            context: context,
                            title: "Saldo Invalido",
                            mensaje: "Su saldo debe ser mayor de S/0.0",
                            monto: double.parse(saldoRetiro));
                      } else if (double.parse(saldoRetiro) <=
                          widget.saldoCuenta) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MetodoRetiro(
                                      saldo: double.parse(saldoRetiro),
                                    )));
                      } else {
                        mostrarAlertaExito(
                            funcion: () {
                              Navigator.of(context).pop();
                            },
                            color: Color.fromARGB(255, 216, 10, 10),
                            icon: Icons.attach_money,
                            context: context,
                            title: "Saldo Insuficiente",
                            mensaje:
                                "Su saldo es insuficiente para realizar el retiro por el monto indicado",
                            monto: double.parse(saldoRetiro));
                      }
                    },
                    child: Text("CONTINUAR")),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ));
  }
}
