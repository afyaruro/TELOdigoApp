import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/domain/models/images.dart'; // Importante: image/image.dart

class CustomImageHotel extends StatefulWidget {


  const CustomImageHotel({
    Key? key,
  }) : super(key: key);

  @override
  _CustomImageHotelState createState() => _CustomImageHotelState();
}

class _CustomImageHotelState extends State<CustomImageHotel> {
  File? _image;
  bool resp = false;
  List<Imagens> images = [];
  static final NegocioController controllerhotel = Get.find();

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
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
}
