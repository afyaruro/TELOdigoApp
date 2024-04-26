import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview4.dart';

class CrearAnuncioMap extends StatefulWidget {
  const CrearAnuncioMap({super.key});

  @override
  State<CrearAnuncioMap> createState() => _CrearAnuncioMapState();
}

const kGoogleApiKey = "AIzaSyCnANhFGwttT-RM2rUhtDas13DRivPQO7Y";

class _CrearAnuncioMapState extends State<CrearAnuncioMap> {
  late GoogleMapController googleMapController;
  LatLng? _selectedLocation;
   static final NegocioController controllerhotel = Get.find();

  Set<Marker> marketList = {};

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-12.04318, -77.02824),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: "");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Ubica tu negocio",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              zoomControlsEnabled: false,
              minMaxZoomPreference: MinMaxZoomPreference(13, 20),
              markers: _selectedLocation != null
                  ? {
                      Marker(
                        markerId: MarkerId('selected-location'),
                        position: _selectedLocation!,
                      ),
                    }
                  : {},
              initialCameraPosition: _cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
              mapType: MapType.normal,
              onTap: (LatLng latLng) {
                setState(() {
                  _selectedLocation = latLng;
                  controllerhotel.EstablecerCoodenadas(_selectedLocation!.latitude, _selectedLocation!.longitude);
                });
              },
            ),
          ),
          Container(
            width: 400,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: GooglePlacesAutoCompleteTextFormField(
                decoration: InputDecoration(
                  hintText: "Busca aquí",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                textEditingController: controller,
                googleAPIKey: "AIzaSyCnANhFGwttT-RM2rUhtDas13DRivPQO7Y",
                debounceTime: 400,
                countries: ["pe"],
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (prediction) {
                  setState(() {
                    double lat = double.parse(prediction.lat!);
                    double lng = double.parse(prediction.lng!);

                    controllerhotel.EstablecerCoodenadas(lat, lng);
                    
                    marketList = {};
                    marketList.add(Marker(
                        markerId: MarkerId("new"), position: LatLng(lat, lng)));
                    _selectedLocation = LatLng(
                      lat,
                      lng,
                    );
                    googleMapController.animateCamera(
                      CameraUpdate.newLatLng(_selectedLocation!),
                    );
                  });
                },
                itmClick: (prediction) {}),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Color.fromARGB(255, 16, 152, 231)),
                  onPressed: _selectedLocation != null
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CrearAnuncioView4()));
                        }
                      : null,
                  child: Text(
                    "Siguiente",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
      // bottomNavigationBar:
    );
  }
}
