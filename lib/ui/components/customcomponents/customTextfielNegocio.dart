
import 'package:flutter/material.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';

class CustomTextFieldNegocio extends StatefulWidget {
  final String nombre;
  final TextEditingController controller;
  final int dimension;
  final NegocioController negocioController;

  const CustomTextFieldNegocio({
    required this.nombre,
    required this.controller,
    required this.dimension,
    required this.negocioController,
  });

  @override
  _CustomTextFieldNegocioState createState() => _CustomTextFieldNegocioState();
}

class _CustomTextFieldNegocioState extends State<CustomTextFieldNegocio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 2),
      width: 400,
      // height: 70,
      child: TextField(
        onChanged: (value) {
          value = value.trim();

          if(widget.nombre == "Dirección"){
            widget.negocioController.NewDireccion(value);
            return;
          }

          // if(widget.nombre == "Ejem. Los Girasoles"){
          //   widget.negocioController.NewNombreNegocio(value);
          //   return;
          // }

          // if(widget.nombre == ""){
          //   widget.negocioController.NewNombreNegocio(value);
          //   return;
          // }
        },
        maxLength: widget.dimension,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          labelText: widget.nombre,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 13),
          counterStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
