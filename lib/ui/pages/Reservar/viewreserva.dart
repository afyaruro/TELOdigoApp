import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(103, 228, 228, 228),
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
                            "${widget.reserva.nombreNegocio}",
                            style: TextStyle(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                  color: widget.reserva.estado == "En espera"
                                      ? Color(0xFF00FF0A)
                                      : const Color.fromARGB(255, 255, 7, 7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dirección: ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Flexible(
                            child: Text(
                          "${widget.reserva.direccion}",
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Habitación: ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Flexible(
                            child: Text(
                          "${widget.reserva.habitacion}",
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hora: ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Flexible(
                            child: Text(
                          "${widget.reserva.horaInicioReserva.toString().padLeft(2, '0')}:${widget.reserva.minutoInicioReserva.toString().padLeft(2, '0')} - ${widget.reserva.horaFinalReserva.toString().padLeft(2, '0')}:${widget.reserva.minutoFinalReserva.toString().padLeft(2, '0')}",
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Codigo: ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Flexible(
                            child: Text(
                          "${widget.reserva.codigo}",
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewChat(
                                            reserva: widget.reserva,
                                          )));
                    }, child: Text("Chatea con el Telo"))
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
