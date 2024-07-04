import 'package:flutter/material.dart';
import 'package:telodigo/domain/models/informe.dart';

class DetalleInforme extends StatelessWidget {
  final Informe informe;

  DetalleInforme({required this.informe});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${informe.fecha.year}-${informe.fecha.month.toString().padLeft(2, '0')}-${informe.fecha.day.toString().padLeft(2, '0')}';
    String formattedTime =
        '${informe.fecha.hour.toString().padLeft(2, '0')}:${informe.fecha.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Detalle del Informe', style: TextStyle(fontSize: 15)),
        backgroundColor: const Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Correo:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 23, 192, 8)),
              ),
              Text(
                informe.correo,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Fecha:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 23, 192, 8)),
              ),
              Text(
                formattedDate,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Hora:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 23, 192, 8)),
              ),
              Text(
                formattedTime,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Mensaje:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 23, 192, 8)),
              ),
              Text(
                informe.mensaje,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
