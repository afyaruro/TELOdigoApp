import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String text;
  const CustomAlert({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 0, 0, 0),),),
      content: Text(text),
      actions: [
        TextButton(
          child: Text('Aceptar'),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
       
      ],
    );
  }
}
