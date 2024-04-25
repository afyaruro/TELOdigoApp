import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img; // Importante: image/image.dart

class ImagenPerfil extends StatefulWidget {
  final TextEditingController imagebyte;

  const ImagenPerfil({
    Key? key,
    required this.imagebyte,
  }) : super(key: key);

  @override
  _ImagenPerfilState createState() => _ImagenPerfilState();
}

class _ImagenPerfilState extends State<ImagenPerfil> {
  File? _image;
  bool resp = false;

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
                  // CircularProgressIndicator(),
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
      widget.imagebyte.text = await imageToBase64(await resizeImage(_image!));
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.only(top: 50, bottom: 20),
            width: 120,
            height: 120,
            child: _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  )

                // : Image.asset("assets/user_perfil.png"),
                : ClipRRect(
                    child: Image.memory(
                      base64Decode(widget.imagebyte.text),
                      fit: BoxFit
                          .cover, // Ajusta la imagen al tamaño del contenedor
                      width: 120,
                      height: 120,
                    ),
                    borderRadius: BorderRadius.circular(60),
                  )),
        Positioned(
          child: InkWell(
            onTap: _pickImage,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(190, 0, 0, 0),
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
          top: 130,
          left: 80,
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
