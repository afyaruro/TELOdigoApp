import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:telodigo/ui/pages/prueba/prueba.dart';

// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

class GestionarMesas extends StatefulWidget {
  const GestionarMesas({Key? key}) : super(key: key);

  @override
  State<GestionarMesas> createState() => _GestionarMesasState();
}

class _GestionarMesasState extends State<GestionarMesas> {
  var _image;
  ImagePicker picker = ImagePicker();
  TextEditingController controlIdMesa = TextEditingController();
  TextEditingController controlNombreMesa = TextEditingController();
  TextEditingController controlDescripcion = TextEditingController();
  // MesaController controlMesa = Get.find();
  String mensaje = "";
  // final RespuestaMesa respuesta = RespuestaMesa();

  _camGaleria(bool op) async {
    XFile? image;
    image = op
        ? await picker.pickImage(source: ImageSource.camera, imageQuality: 50)
        : await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Gestionar Mesas"),
          backgroundColor: const Color(0xFF005E80),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                margin:
                    EdgeInsets.only(top: 100, left: 100, right: 100, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      // _opcioncamara(context);
                      _camGaleria(false);
                    },
                    child: _image != null
                        ? ClipRRect(
                            child: Image.file(
                              _image,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: controlIdMesa,
                  decoration: InputDecoration(
                    labelText: 'Id de la Mesa',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: controlNombreMesa,
                  decoration: InputDecoration(
                    labelText: 'Nombre de la Mesa',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: controlDescripcion,
                  decoration: InputDecoration(
                    labelText: 'Descripcion de la Mesa',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFF005E80),
                        child: IconButton(
                          onPressed: () async {

                            PeticionesMesa.cargarfoto(_image, "Hola2");
                            // respuesta.RespuestaAdd(
                            //     controlIdMesa.text,
                            //     controlNombreMesa.text,
                            //     controlDescripcion.text,
                            //     _image);
                          },
                          icon: Icon(Icons.add),
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFF005E80),
                        child: IconButton(
                          onPressed: () async {
                            // respuesta.RespuestaActualizar(
                            //     controlIdMesa.text,
                            //     controlNombreMesa.text,
                            //     controlDescripcion.text,
                            //     _image);
                          },
                          icon: Icon(Icons.create_rounded),
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFF005E80),
                        child: IconButton(
                          onPressed: () async {
                            // respuesta.RespuestaConsultarxId(
                            //     controlIdMesa.text, controlMesa);
                          },
                          icon: Icon(Icons.search),
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFF005E80),
                        child: IconButton(
                          onPressed: () async {
                            // respuesta.RespuestaDelete(controlIdMesa.text);
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.white,
                        )),
                  )
                ],
              ),
              SizedBox(
                width: 20,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

//Seleccionar la camara o la galeria

  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Imagen de Galeria'),
                    onTap: () {
                      _camGaleria(false);
                      Get.back();
                      // Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Capturar Imagen'),
                  onTap: () {
                    _camGaleria(true);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
