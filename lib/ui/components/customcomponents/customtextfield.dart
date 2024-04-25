import 'package:flutter/material.dart';

class CustomTextField1 extends StatefulWidget {
  final String nombre;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField1({
    required this.nombre,
    required this.isPassword,
    required this.controller,
  });

  @override
  _CustomTextField1State createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical:  5),
      height: 50,
      width: 400,
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.top,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: widget.nombre,
          labelStyle: TextStyle(color: Colors.white, fontSize: 13),
          suffixIcon: widget.isPassword ? IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, size: 20,),
            color: Colors.white,

          ) : null,
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}


Widget CustomTextField2(String nombre,  TextEditingController controller){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical:  5),
    height: 50,
    width: 400,
    child: TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.top,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide:
              BorderSide(color: Color.fromARGB(190, 0, 0, 0)), // Color del borde exterior
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide: BorderSide(
              color: Color.fromARGB(190, 0, 0, 0)), // Color del borde exterior cuando el TextField está deshabilitado
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide: BorderSide(
              color: Color.fromARGB(190, 0, 0, 0)), // Color del borde exterior cuando el TextField está enfocado
        ),
        labelText: nombre,
        labelStyle: const TextStyle(color: Color.fromARGB(190, 0, 0, 0), fontSize: 13), // Color del texto del label
      ),
      style: TextStyle(
          color: Color.fromARGB(190, 0, 0, 0),), // Color del texto dentro del TextField
    ),
  );
}

Widget CustomTextField3(String nombre,  TextEditingController controller){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical:  5),
    height: 50,
    width: 400,
    child: TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide:
              BorderSide(color: Color.fromARGB(190, 0, 0, 0)), // Color del borde exterior
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide: BorderSide(
              color: Color.fromARGB(190, 0, 0, 0)), // Color del borde exterior cuando el TextField está deshabilitado
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide: BorderSide(
              color: Color.fromARGB(190, 0, 0, 0)), // Color del borde exterior cuando el TextField está enfocado
        ),
        labelText: nombre,
        labelStyle: TextStyle(color: Color.fromARGB(190, 0, 0, 0), fontSize: 13), // Color del texto del label
      ),
      style: TextStyle(
          color: Color.fromARGB(190, 0, 0, 0),), // Color del texto dentro del TextField
    ),
  );
}
