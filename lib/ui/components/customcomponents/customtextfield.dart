// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 50,
      width: 400,
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.top,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          labelText: widget.nombre,
          labelStyle: const TextStyle(color: Colors.white, fontSize: 13),
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
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget CustomTextField2(String nombre, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
          borderSide: const BorderSide(
              color: Color.fromARGB(190, 0, 0, 0)), // Color del borde exterior
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide: const BorderSide(
              color: Color.fromARGB(190, 0, 0,
                  0)), // Color del borde exterior cuando el TextField está deshabilitado
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide: const BorderSide(
              color: Color.fromARGB(190, 0, 0,
                  0)), // Color del borde exterior cuando el TextField está enfocado
        ),
        labelText: nombre,
        labelStyle: const TextStyle(
            color: Color.fromARGB(190, 0, 0, 0),
            fontSize: 13), // Color del texto del label
      ),
      style: const TextStyle(
        color: Color.fromARGB(190, 0, 0, 0),
      ), // Color del texto dentro del TextField
    ),
  );
}

Widget CustomTextField3(String nombre, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    height: 50,
    width: 400,
    child: TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide: const BorderSide(
              color: Color.fromARGB(190, 0, 0, 0)), // Color del borde exterior
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide: const BorderSide(
              color: Color.fromARGB(190, 0, 0,
                  0)), // Color del borde exterior cuando el TextField está deshabilitado
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Ajusta el radio de los bordes según lo necesites
          borderSide: const BorderSide(
              color: Color.fromARGB(190, 0, 0,
                  0)), // Color del borde exterior cuando el TextField está enfocado
        ),
        labelText: nombre,
        labelStyle: const TextStyle(
            color: Color.fromARGB(190, 0, 0, 0),
            fontSize: 13), // Color del texto del label
      ),
      style: const TextStyle(
        color: Color.fromARGB(190, 0, 0, 0),
      ), // Color del texto dentro del TextField
    ),
  );
}

class CustomTextField4 extends StatefulWidget {
  final String nombre;
  final bool isPassword;
  final TextEditingController controller;
  final double height;
  final double width;

  const CustomTextField4({
    required this.nombre,
    required this.isPassword,
    required this.controller,
    required this.height,
    required this.width,
  });

  @override
  _CustomTextField4State createState() => _CustomTextField4State();
}

class _CustomTextField4State extends State<CustomTextField4> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.top,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
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
          labelStyle: const TextStyle(color: Colors.white, fontSize: 13),
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
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}


class CustomTextField5 extends StatefulWidget {
  final String nombre;
  final bool isPassword;
  final TextEditingController controller;
  final double height;
  final double width;
  final double textFontSize;
  final String placeholder;
  VoidCallback funtion;
  List<TextInputFormatter> inputFormater;
  TextInputType keyboard;


  CustomTextField5({super.key,
    required this.nombre,
    required this.isPassword,
    required this.controller,
    required this.height,
    required this.width,
    required this.textFontSize,
    required this.placeholder,
    required this.funtion,
    required this.inputFormater,
    required this.keyboard,
    
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextField5State createState() => _CustomTextField5State();
}

class _CustomTextField5State extends State<CustomTextField5> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextField(
        onChanged: (text){
          setState(() {
            widget.funtion();
          });

        },
        keyboardType:widget.keyboard,
        inputFormatters: widget.inputFormater,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal:15),
          hintText: widget.placeholder,
          hintStyle: TextStyle(color: Colors.white, fontSize: widget.textFontSize),
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
          labelStyle:TextStyle(color: Colors.white, fontSize: widget.textFontSize),
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
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}


class CustomComboBoxbutton extends StatefulWidget {
  List<String> data;
  String initText;
  double height;
  CustomComboBoxbutton({super.key, required this.data,required this.initText,required this.height});

  @override
  State<CustomComboBoxbutton> createState() => _CustomComboBoxbuttonState();
}

class _CustomComboBoxbuttonState extends State<CustomComboBoxbutton> {
  @override
  Widget build(BuildContext context) {
    String selectedItem = widget.data[0];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(widget.height/4),color:Colors.white),
      child: DropdownButton(
          underline: const SizedBox(),
          style: const TextStyle(color:Colors.black45 ),
          isExpanded: true,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
          value: selectedItem,
          dropdownColor: Colors.white,
          items: widget.data.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
                  if (newValue != null) {
                    // Actualizar el valor seleccionado cuando cambia
                    selectedItem = newValue;
                    // Llamar a setState para que Flutter repinte el widget
                    setState(() {});
                  }
                },),
    );
  }
}
// DropdownButton(
//           style: TextStyle(color:Colors.black45 ),
//           isExpanded: true,
//           padding: EdgeInsetsDirectional.symmetric(horizontal: ),
//           value: selectedItem,
//           dropdownColor: Colors.white,
//           items: widget.data.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     // Actualizar el valor seleccionado cuando cambia
//                     selectedItem = newValue;
//                     // Llamar a setState para que Flutter repinte el widget
//                     setState(() {});
//                   }
//                 },),