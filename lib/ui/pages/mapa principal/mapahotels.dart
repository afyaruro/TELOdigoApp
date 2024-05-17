import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telodigo/data/controllers/mapcontroller.dart';
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

  @override
  void initState() {
    super.initState();

    _cameraPosition = CameraPosition(
        target: LatLng(controller.latitud, controller.logitud), zoom: 14.4746);
    cargarNegociosEnMapa();
  }

  Future<void> cargarNegociosEnMapa() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection("Negocios");
    QuerySnapshot querySnapshot = await collection.get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Hoteles hotel = Hoteles.desdeDoc(jsonData);
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

        setState(() {});
      }
    }
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
      body: SingleChildScrollView(
        child: Stack(
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
            _selectedHotel != null
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 190, 190, 190)
                                  .withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 150,
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
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedHotel!.nombre,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                                EstrellasPoint(_selectedHotel!.calificacion),
                                Text(
                                  'S/${_selectedHotel!.habitaciones[0].precios[0].precio}',
                                ),
                                Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewHotelCliente(
                                                        hotel: _selectedHotel!,
                                                      )));
                                        },
                                        child: Text("Ver Hotel")))
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
        ),
      ),
    );
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
