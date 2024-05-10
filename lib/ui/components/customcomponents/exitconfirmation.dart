import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Salir de la aplicación'),
      content: Text('¿Está seguro de que desea salir de la aplicación?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); 
            
            // Confirmar la acción
          },
          child: Text('Salir'),
        ),
      ],
    );
  }
}