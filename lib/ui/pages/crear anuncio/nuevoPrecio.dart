import 'package:flutter/material.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview6.dart';

class NuevoPrecio extends StatefulWidget {
  final Habitaciones habitacion;

  const NuevoPrecio({super.key, required this.habitacion});

  @override
  State<NuevoPrecio> createState() => _NuevoPrecioState();
}

class _NuevoPrecioState extends State<NuevoPrecio> {
  int selectedNumber = 1;
  TextEditingController controller = TextEditingController(text: "0");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 21, 1, 37),
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Añade un nuevo precio",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 15,
            ),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Column(children: [
              const SizedBox(height: 150),
              Container(
                width: 400,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Nuevo Precio",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                width: 400,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Horas:  "),
                        DropdownButton<int>(
                          value: selectedNumber, 
                          items: List.generate(24, (index) {
                            return DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text((index + 1).toString()),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              selectedNumber =
                                  value!; 
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Precio:  "),
                        Container(
                          width: 70,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black38,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Agrega un precio",
                            text: "Por favor agrega un precio para continuar",
                          );
                        },
                      );
                    } else if (double.tryParse(controller.text) == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Valor Invalido",
                            text: "El valor ingresado es invalido",
                          );
                        },
                      );
                    } else if(double.parse(controller.text) == 0){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Valor Invalido",
                            text: "El valor ingresado debe ser mayor de 0",
                          );
                        },
                      );
                    } else {
                      Precios precios = Precios(
                          precio: double.parse(controller.text),
                          hora: selectedNumber);
                      widget.habitacion.precios.add(precios);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CrearAnuncioView6()));
                    }
                  },
                  child: Text("Añadir Precio"))
            ]))));
  }
}
