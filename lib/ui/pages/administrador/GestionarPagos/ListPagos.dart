import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesadmin.dart';
import 'package:telodigo/domain/models/solicitdPago.dart';
import 'package:telodigo/ui/pages/administrador/GestionarPagos/detallesPagos.dart';

class ListPagos extends StatefulWidget {
  const ListPagos({super.key});

  @override
  State<ListPagos> createState() => _ListPagosState();
}

class _ListPagosState extends State<ListPagos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pagos en Espera',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: FutureBuilder<List<SolicitudPago>>(
        future: PeticionesAdmin.obtenerPagosEnEspera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Text(
              "Cargando Pagos...",
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
              'No hay pagos en espera disponibles',
              style: TextStyle(color: Colors.white),
            ));
          } else {
            List<SolicitudPago> pagos = snapshot.data!;

            // Ordenar los pagos por fecha, del más antiguo al más nuevo
            pagos.sort((a, b) => a.fecha.compareTo(b.fecha));

            return ListView.builder(
              itemCount: pagos.length,
              itemBuilder: (context, index) {
                SolicitudPago pago = pagos[index];
                String formattedDate =
                    '${pago.fecha.year}-${pago.fecha.month.toString().padLeft(2, '0')}-${pago.fecha.day.toString().padLeft(2, '0')}';
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallePago(pago: pago),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(pago.concepto,
                        style: const TextStyle(color: Color.fromARGB(255, 115, 86, 223))),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pago.userAnfitrion,
                        style: const TextStyle(color: Colors.white)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Fecha: $formattedDate',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'S/${pago.monto}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      ],
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
