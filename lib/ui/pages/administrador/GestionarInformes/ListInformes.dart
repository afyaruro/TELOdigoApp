import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesadmin.dart';
import 'package:telodigo/domain/models/informe.dart';
import 'package:telodigo/ui/pages/administrador/GestionarInformes/detalleInforme.dart';

class ListInformes extends StatelessWidget {
  const ListInformes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Informes de Problemas',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: FutureBuilder<List<Informe>>(
        future: PeticionesAdmin.obtenerInformes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Text(
              "Cargando Informes...",
              style: TextStyle(color: Colors.white),
            ));
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              'No hay informes disponibles',
              style: TextStyle(color: Colors.white),
            ));
          } else {
            List<Informe> informes = snapshot.data!;
            return ListView.builder(
              itemCount: informes.length,
              itemBuilder: (context, index) {
                Informe informe = informes[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleInforme(informe: informe),
                      ),
                    );
                  },
                  child: ListTile(
                    title: const Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Color.fromARGB(255, 235, 82, 82),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Infome de Error",
                            style: TextStyle(
                                color: Color.fromARGB(255, 235, 82, 82))),
                      ],
                    ),
                    subtitle: Text(
                      'Fecha: ${informe.fecha.year}-${informe.fecha.month.toString().padLeft(2, '0')}-${informe.fecha.day.toString().padLeft(2, '0')}\nHora: ${informe.fecha.hour.toString().padLeft(2, '0')}:${informe.fecha.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
