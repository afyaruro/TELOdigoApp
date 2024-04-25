import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:telodigo/domain/models/images.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview9.dart'; // Importante: image/image.dart

class CrearAnuncioView8 extends StatefulWidget {
  const CrearAnuncioView8({super.key});

  @override
  State<CrearAnuncioView8> createState() => _CrearAnuncioView8State();
}

class _CrearAnuncioView8State extends State<CrearAnuncioView8> {
  TextEditingController controller = TextEditingController(text: "");
  TextEditingController cant = TextEditingController(text: "0");
  static final NegocioController controllerhotel = Get.find();


File? _image;
  bool resp = false;
  List<Imagens> images = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text("Cargando tu foto..."),
            ],
          ),
        );
      },
    );

    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        resp = true;
      } else {
        print('No se seleccionó ninguna imagen.');
        resp = false;
      }
    });

    if (resp == true) {
      Imagens imagen =
          Imagens(image: await imageToBase64(await resizeImage(_image!)));
      images.add(imagen);
      controllerhotel.NewImagen(images);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }

    setState(() {});
  }

    Future<String> imageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<File> resizeImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    final resizedImage = img.copyResize(image!, width: 200);
    final resizedFile = File(imageFile.path)
      ..writeAsBytesSync(img.encodeJpg(resizedImage));
    return resizedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 8 de 9",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Column(children: [
            const SizedBox(height: 50),
            Container(
              width: 400,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Agrega algunas fotos de tu negocio",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 400,
              margin: EdgeInsets.only(top: 10),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Para empezar necesitas tres fotos.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: InkWell(
            onTap: _pickImage,
            child: Container(
              width: 400,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 2.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text(
                    "Agregar imagen",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var imagen in images)
              Stack(
                children: [
                  ClipRRect(
                    child: Image.memory(
                      base64Decode(imagen.image),
                      fit: BoxFit.cover,
                      width: 130,
                      height: 130,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  Positioned(
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Eliminar Imagen'),
                                  content: Container(
                                    height: 190,
                                    child: Column(
                                      children: [
                                        Text(
                                            '¿Estás seguro de que deseas eliminar esta imagen?'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ClipRRect(
                                          child: Image.memory(
                                            base64Decode(imagen.image),
                                            fit: BoxFit.cover,
                                            width: 130,
                                            height: 130,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        images.remove(imagen);
                                        controllerhotel.deleteImagen(imagen);

                                        setState(() {});
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Eliminar'),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(
                          Icons.close,
                          size: 20,
                          color: Color.fromARGB(255, 90, 2, 141),
                        )),
                    right: 0,
                  )
                ],
              ),
          ],
        )
      ],
    )
          ]))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color(0xFF1098E7)),
            onPressed: images.length > 2
                ? () {
                    Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CrearAnuncioView9()));
                  }
                : null,

            child: Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
