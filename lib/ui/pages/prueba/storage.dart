import 'package:flutter/material.dart';
import 'package:telodigo/ui/pages/prueba/peticionesMPCard.dart';
import 'package:uuid/uuid.dart';

class CrearClienteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Crear Cliente'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              var x = await PeticionesMPCard.asociarTarjetaACliente();
              await PeticionesMPCard.realizarPago(x);
              
            },
            child: Text('Crear Cliente'),
          ),
        ),
      ),
    );
  }
}
