import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/reportePago.dart';

class Reportes extends StatefulWidget {
  const Reportes({super.key});

  @override
  State<Reportes> createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  double ingresosUltimoMes = 0;
  int numeroReservasTotal = 0;
  double valoracionGeneral = 0;
  int visitasUltimoMes = 0;
  bool _isLoading = true;
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("Reportes");
  final collection2 = FirebaseFirestore.instance.collection('Calificaciones');
  final UserController controlleruser = Get.find();

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    double ingresos = await obtenerIngresosUltimoMes();
    int reservas = await obtenerNumeroReservasTotal();
    double valoracion = await obtenerValoracionGeneral();
    int visitas = await obtenerVisitasUltimoMes();

    setState(() {
      ingresosUltimoMes = ingresos;
      numeroReservasTotal = reservas;
      valoracionGeneral = valoracion;
      visitasUltimoMes = visitas;
      _isLoading = false; // La carga de datos ha terminado
    });
  }

  Future<double> obtenerIngresosUltimoMes() async {
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;

    CollectionReference reportesRef =
        FirebaseFirestore.instance.collection('ReportesPagos');
    double saldo = 0;
    QuerySnapshot querySnapshot = await reportesRef
        .where('userAnfitrion', isEqualTo: controlleruser.usuario!.userName)
        .get();

    querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DateTime fecha = (data['fecha'] as Timestamp).toDate();
      if (fecha.month == currentMonth && fecha.year == currentYear) {
        ReportePago reportePago = ReportePago.fromJson(data);
        saldo = saldo + reportePago.valor;
      }
    }).toList();
    return saldo;
  }

  Future<int> obtenerNumeroReservasTotal() async {
    final querySnapshot = await collection
        .where('userAnfitrion', isEqualTo: controlleruser.usuario!.userName)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final reporteDoc = querySnapshot.docs.first;
      final reporteData = reporteDoc.data() as Map<String, dynamic>;
      final int numeroReservas = reporteData['numeroReservas'] as int;
      return numeroReservas;
    }

    return 0;
  }

  Future<double> obtenerValoracionGeneral() async {
    final querySnapshot = await collection2
        .where('idUserNegocio', isEqualTo: controlleruser.usuario!.userName)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return 0.0;
    }

    double totalCalificaciones = 0;
    int cantidadCalificaciones = 0;

    querySnapshot.docs.forEach((doc) {
      totalCalificaciones += doc['calificacion'];
      cantidadCalificaciones++;
    });

    return totalCalificaciones / cantidadCalificaciones;
  }

  Future<int> obtenerVisitasUltimoMes() async {
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;

    CollectionReference reportesRef =
        FirebaseFirestore.instance.collection('ReportesView');
    int cont = 0;
    QuerySnapshot querySnapshot = await reportesRef
        .where('userAnfitrion', isEqualTo: controlleruser.usuario!.userName)
        .get();

    querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DateTime fecha = (data['fecha'] as Timestamp).toDate();
      if (fecha.month == currentMonth && fecha.year == currentYear) {
        cont = cont + 1;
      }
    }).toList();
    return cont;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 60,
      color: const Color.fromARGB(255, 29, 7, 48),
      child: _isLoading
          ? const Center(
              // child: CircularProgressIndicator(),
              child: Text(
                "Cargando Balance...",
                style: TextStyle(color: Colors.white),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(30),
                    child: const Text(
                      "Datos Importantes",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "S/$ingresosUltimoMes",
                                style: TextStyle(
                                    color: Color(0xFF8402F4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "Ingresos del último mes",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "$numeroReservasTotal",
                                style: TextStyle(
                                    color: Color(0xFF8402F4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "Número de reservas en total",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 13),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "${valoracionGeneral.toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Color(0xFF8402F4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "Valoración General",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "$visitasUltimoMes",
                                style: TextStyle(
                                    color: Color(0xFF8402F4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "Visitas en el último mes",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 13),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
