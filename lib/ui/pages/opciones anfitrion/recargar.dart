import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/pages/opciones%20anfitrion/configure_card.dart';
import 'package:telodigo/data/service/peticionesPagoMP.dart';

class Recargar extends StatefulWidget {
  final List<Hoteles> hoteles;
  const Recargar({super.key, required this.hoteles});

  @override
  State<Recargar> createState() => _RecargarState();
}

class _RecargarState extends State<Recargar> {
  TextEditingController saldo = TextEditingController(text: "");

  String selectedNegocio = "";

  @override
  void initState() {
    super.initState();
    saldo = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      leftSymbol: 'S/ ',
    );
    saldo.text = "S/0.00";
    if (widget.hoteles.isNotEmpty) {
      selectedNegocio = widget.hoteles[0].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Recargar",
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
                widget.hoteles.isEmpty
                    ? Text(
                        "No tienes establecimientos para recargar",
                        style: TextStyle(color: Colors.white),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          iconEnabledColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          style: TextStyle(color: Colors.white),
                          value: selectedNegocio,
                          dropdownColor: Color.fromARGB(255, 108, 108, 150),
                          items: widget.hoteles.map((hotel) {
                            return DropdownMenuItem(
                              value: hotel.id,
                              child: Center(child: Text(hotel.nombre)),
                            );
                          }).toList(),
                          onChanged: (String? selectedHotel) {
                            setState(() {
                              selectedNegocio = selectedHotel!;
                            });
                          },
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: widget.hoteles.isEmpty
                        ? null
                        : () {
                            String variable = saldo
                                .text; // Variable con el valor que contiene números y texto
                            RegExp exp = RegExp(
                                r"[0-9,.]"); // Expresión regular para identificar números, comas y puntos decimales
                            String numeros = variable.replaceAll(
                                RegExp(r"[^\d\,.]"),
                                ""); // Reemplaza todo lo que no sea números, comas o puntos decimales por una cadena vacía
                            numeros = numeros.replaceAll(".", "");
                            String saldoRecarga = numeros.replaceAll(",", ".");
                            // print(saldo.text);
                            if (double.parse(saldoRecarga) > 5.0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConfigureCard(
                                            motivo: "Recarga",
                                            id: selectedNegocio,
                                            saldo: double.parse(saldoRecarga),
                                          )));
                            } else {
                              mostrarAlertaExito(
                                  funcion: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: Color.fromARGB(255, 216, 10, 10),
                                  icon: Icons.attach_money,
                                  context: context,
                                  title: "Saldo Invalido",
                                  mensaje: "Su saldo debe ser mayor de S/5",
                                  monto: double.parse(saldoRecarga));
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
