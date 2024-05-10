import 'package:flutter/material.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/pages/home%20anfitrion/homeanfitrion.dart';

class VerificarCodigo extends StatefulWidget {
  final Reserva reserva;
  const VerificarCodigo({super.key, required this.reserva});

  @override
  State<VerificarCodigo> createState() => _VerificarCodigoState();
}

class _VerificarCodigoState extends State<VerificarCodigo> {
  TextEditingController controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 29, 7, 48),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 100, left: 30, right: 30),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          color: widget.reserva.metodoPago != "Efectivo"
                              ? Color(0xFF00FF0A)
                              : const Color.fromARGB(255, 255, 7, 7),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      widget.reserva.metodoPago != "Efectivo"
                          ? "Pago"
                          : "No ha Pagado",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: EdgeInsets.only(right: 30, left: 30, top: 40),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(75),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image.network(
                          widget.reserva.fotoPrincipal,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                            width: 130,
                            child: Text(
                              "${widget.reserva.nombreNegocio}",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 136, 130, 196),
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                            width: 130,
                            child: Text(
                              "Reservado por:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                            width: 130,
                            child: Text(
                              "${widget.reserva.idUser}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hora",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${widget.reserva.horaInicioReserva.toString().padLeft(2, '0')}:${widget.reserva.minutoInicioReserva.toString().padLeft(2, '0')} - ${(widget.reserva.horaFinalReserva).toString().padLeft(2, '0')}:${widget.reserva.minutoFinalReserva.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Habitacion",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${widget.reserva.habitacion} - ${widget.reserva.tiempoReserva} h",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Información del precio",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOTAL: ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "S/${widget.reserva.precio}",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 40, bottom: 40),
                  child: CustomTextField1(
                      nombre: "Codigo: ",
                      isPassword: false,
                      controller: controller)),
              ElevatedButton(
                  onPressed: () async {
                    if (controller.text == widget.reserva.codigo) {
                      await PeticionesReserva.VerificarCodigo(
                          widget.reserva.key,
                          widget.reserva.idHotel,
                          widget.reserva.metodoPago,
                          context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeAnfitrion(
                                    currentIndex: 2,
                                  )));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Codigo Incorrecto",
                            text:
                                "El codigo que has proporcionado es incorrecto",
                          );
                        },
                      );
                    }
                  },
                  child: Text("Verificar Codigo"))
            ],
          ),
        ),
      ),
    );
  }
}
