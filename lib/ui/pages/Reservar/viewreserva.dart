import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/pages/chats/viewchat.dart';

class ViewReserva extends StatefulWidget {
  final Reserva reserva;
  const ViewReserva({super.key, required this.reserva});

  @override
  State<ViewReserva> createState() => _ViewReservaState();
}

class _ViewReservaState extends State<ViewReserva> {
  static late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();

    _cameraPosition = CameraPosition(
      target: LatLng(widget.reserva.latitud, widget.reserva.longitud),
      zoom: 14.4746,
    );
  }

  String calcularHoraReserva(Reserva reserva) {
    int hour = reserva.horaInicioReserva;
    int hourFinal = reserva.horaFinalReserva;

    int minute = reserva.horaInicioReserva;

    hour = hour % 24;
    hourFinal = hourFinal % 24;

    // Determine AM or PM based on hour
    // String amPm = hour > 12 ? "PM" : "AM";
    String amPm = hour >= 12 ? "PM" : "AM";
    String amPmFinal = hourFinal >= 12 ? "PM" : "AM";

    // Adjust hour for 12-hour format
    if (hour >= 12) {
      hour -= 12;
    }

    if (hourFinal >= 12) {
      hourFinal -= 12;
    }

    // Format hour and minute with leading zeros
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedHourFinal = hourFinal.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    // Construct and return the non-military time string
    return "${formattedHour}:${formattedMinute} $amPm - ${formattedHourFinal}:${formattedMinute} $amPmFinal";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mi reserva",
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(103, 228, 228, 228),
            child: GoogleMap(
              initialCameraPosition: _cameraPosition,
              zoomControlsEnabled: false,
              minMaxZoomPreference: MinMaxZoomPreference(13, 20),
              markers: {
                Marker(
                  markerId: MarkerId('selected-location'),
                  position:
                      LatLng(widget.reserva.latitud, widget.reserva.longitud),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueViolet),
                )
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.reserva.nombreNegocio,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                  color: widget.reserva.estado == "En espera"
                                      ? const Color(0xFF00FF0A)
                                      : const Color.fromARGB(255, 255, 7, 7),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6))),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.reserva.estado == "En espera"
                                  ? "En espera"
                                  : "Culminado",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 17, 17, 17),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Dirección: ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Flexible(
                            child: Text(
                          widget.reserva.direccion,
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Habitación: ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Flexible(
                            child: Text(
                          widget.reserva.habitacion,
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Hora: ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Flexible(
                            child: Text(
                          calcularHoraReserva(widget.reserva),
                          // "${widget.reserva.horaInicioReserva.toString().padLeft(2, '0')}:${widget.reserva.minutoInicioReserva.toString().padLeft(2, '0')} - ${(widget.reserva.horaFinalReserva).toString().padLeft(2, '0')}:${widget.reserva.minutoFinalReserva.toString().padLeft(2, '0')}",
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Valor: ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Flexible(
                            child: Text(
                          "S/${widget.reserva.precio}",
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Codigo: ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Flexible(
                            child: Text(
                          widget.reserva.codigo,
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewChat(
                                        reserva: widget.reserva,
                                      )));
                        },
                        child: const Text("Chatea con el Telo"))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
