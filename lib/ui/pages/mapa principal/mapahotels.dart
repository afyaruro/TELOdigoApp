import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telodigo/data/controllers/mapcontroller.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/data/service/peticionesReporte.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/pages/view%20hotel/viewhotelclientes.dart';

class MapaHotels extends StatefulWidget {
  const MapaHotels({Key? key}) : super(key: key);

  @override
  State<MapaHotels> createState() => _MapaHotelsState();
}

class _MapaHotelsState extends State<MapaHotels> {
  Set<Marker> markerList = {};
  final List<Hoteles> hoteles = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController? _mapController;
  Hoteles? _selectedHotel;
  static final MapController controller = Get.find();

  static late CameraPosition _cameraPosition;
  bool _isLoading = true;

//nuevo
  late StreamSubscription<Position> _positionStream;

  Future<Uint8List> _createCustomMarkerBitmap() async {
    final double size = 40.0; // Tamaño del marcador
    final double borderWidth = 5.0; // Ancho del borde
    final double shadowOffset = 10.0; // Offset para la sombra

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()
      ..color = Color.fromARGB(255, 194, 42, 42)
      ..style = PaintingStyle.fill;

    // Dibujar el círculo azul con sombra
    final double radius = size / 2;
    final Offset center = Offset(radius + shadowOffset, radius + shadowOffset);
    final Path path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    canvas.drawShadow(path, Colors.black, 3.0, true);
    canvas.drawCircle(center, radius, paint);

    // Dibujar el borde alrededor del círculo
    final Paint borderPaint = Paint()
      ..color = Color.fromARGB(255, 189, 77, 77).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawCircle(center, radius + borderWidth / 2, borderPaint);

    // Dibujar la palabra "Tú" en el centro del círculo
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    textPainter.text = TextSpan(
      text: 'Tú',
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );

    final ui.Image image = await pictureRecorder.endRecording().toImage(
          (size + shadowOffset * 2).toInt(),
          (size + shadowOffset * 2).toInt(),
        );

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();

    _cameraPosition = CameraPosition(
        target: LatLng(controller.latitud, controller.logitud), zoom: 15.4746);
    cargarNegociosEnMapa();

    // PeticionesReserva.actualizarCulminado(context, "user");

    PeticionesReserva.cancelarReservas(context);
    PeticionesReserva.calificar(context);
    PeticionesReserva.culminado(context);

//nuevo
    _positionStream =
        Geolocator.getPositionStream().listen((Position position) {
      updateMarkerPosition(position);
    });
  }

//nuevo
  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

//nuevo
  void updateMarkerPosition(Position position) async {
    final Uint8List markerIcon = await _createCustomMarkerBitmap();
    // print("escuchando si me muevo y repintando");

    setState(() {
      markerList.removeWhere((marker) => marker.markerId.value == "0");
      markerList.add(Marker(
        markerId: MarkerId("0"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.fromBytes(markerIcon),
      ));
    });
  }

  Future<void> cargarNegociosEnMapa() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection("Negocios");
    QuerySnapshot querySnapshot =
        await collection.where('estado', isEqualTo: "verificado").get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;

        Hoteles hotel = Hoteles.desdeDoc(jsonData);
        if (hotel.saldo > 5.0) {
          var bitMapData = await _createMarker(
              80, 80, "S/${hotel.habitaciones[0].precios[0].precio}");
          var bitmapdescriptor = BitmapDescriptor.fromBytes(bitMapData);

          markerList.add(Marker(
              markerId: MarkerId(hotel.id.toString()),
              position: LatLng(hotel.latitud, hotel.longitud),
              icon: bitmapdescriptor,
              infoWindow: InfoWindow(
                title: hotel.nombre,
                snippet: 'S/${hotel.habitaciones[0].precios[0].precio}',
              ),
              onTap: () {
                setState(() {
                  _selectedHotel = hotel;
                });
              }));
        }

        setState(() {});
      }
    }

    final Uint8List markerIcon = await _createCustomMarkerBitmap();
    markerList.add(Marker(
      markerId: MarkerId("0"),
      position: LatLng(controller.latitud, controller.logitud),
      // icon: BitmapDescriptor.defaultMarker,
      icon: BitmapDescriptor.fromBytes(markerIcon),
    ));

    setState(() {
      _isLoading = false;
    });
  }

  Future<Uint8List> _createMarker(int width, int height, String name) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()
      ..color = Color.fromARGB(255, 58, 16, 107)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Ajusta el grosor del borde según sea necesario

    final double radius = 40.0;
    final Rect ovalRect = Rect.fromCircle(
        center: Offset(width * 0.5, height * 0.5), radius: radius);

    canvas.drawOval(ovalRect, paint);
    canvas.drawOval(ovalRect, borderPaint); // Dibuja el borde

    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    painter.text = TextSpan(
      text: name,
      style: TextStyle(fontSize: 15, color: Colors.white),
    );

    painter.layout();
    painter.paint(
      canvas,
      Offset(
        (width * 0.5) - painter.width * 0.5,
        (height * 0.5) - painter.height * 0.5,
      ),
    );

    final img = await pictureRecorder.endRecording().toImage(width, height);
    final ByteData? data = await img.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 60,
              child: GoogleMap(
                initialCameraPosition: _cameraPosition,
                zoomControlsEnabled: false,
                markers: markerList,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
            ),
            _isLoading
                ? Center(
                    // child: CircularProgressIndicator(),
                    child: Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(child: Text("Cargando Mapa...")),
                    ),
                  )
                : const SizedBox(),
            _selectedHotel != null
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 350, // Ancho fijo
                      height: 180,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 190, 190, 190)
                                .withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 160,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                _selectedHotel!.fotos[0].image,
                                width: 150,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            // color: Colors.amber,
                            // width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _selectedHotel = null;
                                          });
                                        },
                                        icon: const Icon(Icons.close)),
                                  ],
                                ),
                                Text(
                                  _selectedHotel!.nombre,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                                EstrellasPoint(_selectedHotel!.calificacion),
                                Text(
                                  'S/${_selectedHotel!.habitaciones[0].precios[0].precio}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child:
                                                      CircularProgressIndicator(),
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Text("Cargando Negocio..."),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                      PeticionesReporte.reporteViewAdd(
                                          _selectedHotel!.user);

                                      bool isFavorito =
                                          await PeticionesNegocio.isFavorito(
                                              _selectedHotel!.id);
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewHotelCliente(
                                            hotel: _selectedHotel!,
                                            estadoFavorito: isFavorito,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("Ver Hotel"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Agrega más detalles del hotel si es necesario
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ));
  }

  Widget EstrellasPoint(double est) {
    if (est >= 1 && est < 1.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 1.5 && est < 2) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 2 && est < 2.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 2.5 && est < 3) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 3 && est < 3.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 3.5 && est < 4) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 4 && est < 4.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 4.5 && est < 5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est == 5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 0.5 && est < 1) {
      return Row(
        children: [
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    }

    return Row(
      children: [
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
      ],
    );
  }
}
