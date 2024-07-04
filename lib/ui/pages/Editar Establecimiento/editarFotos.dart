import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:telodigo/domain/models/images.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';

class ImageCarouselEdit extends StatefulWidget {
  final List<Imagens> imageUrls;
  final List<Imagens> imagenesNuevas;
  final List<Imagens> imagenesEliminadas;

  const ImageCarouselEdit({
    Key? key,
    required this.imageUrls,
    required this.imagenesNuevas,
    required this.imagenesEliminadas,
  }) : super(key: key);

  @override
  _ImageCarouselEditState createState() => _ImageCarouselEditState();
}

class _ImageCarouselEditState extends State<ImageCarouselEdit> {
  int _currentIndex = 0;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    List<Imagens> allImages = [...widget.imageUrls, ...widget.imagenesNuevas];

    return Column(
      children: [
        CarouselSlider(
          items: allImages.map((imagens) {
            return Builder(
              builder: (context) {
                bool isLocal = !imagens.image.startsWith('http');
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: isLocal
                        ? Image.file(
                            File(imagens.image),
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            imagens.image,
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: allImages.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = entry.key;
                });
              },
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
        Wrap(
          spacing: 20,
          runSpacing: 5,
          children: [
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: _eliminarImagen,
                child: Text("Eliminar Imagen"),
              ),
            ),
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  _opcioncamara(context);
                },
                child: Text("Agregar Imagen"),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _agregarImagen(bool op) async {
    final pickedFile = op
        ? await _picker.pickImage(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        widget.imagenesNuevas.add(Imagens(image: pickedFile.path));
        // widget.imageUrls.add(Imagens(image: pickedFile.path));
      });
    }
  }

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
                  _agregarImagen(true);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Capturar Imagen'),
                onTap: () {
                  _agregarImagen(false);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _eliminarImagen() {
    setState(() {
      List<Imagens> allImages = [...widget.imageUrls, ...widget.imagenesNuevas];
      Imagens imageToDelete = allImages[_currentIndex];

      if (allImages.length <= 3) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomAlert(
                title: "No es posible Eliminar...",
                text:
                    "No es posible eliminar alguna otra imagen ya que el limite minimo de imagenes es 3");
          },
        );
      } else {
        bool isLocal = !imageToDelete.image.startsWith('http');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Eliminar Imagen'),
                content: Container(
                  height: 190,
                  child: Column(
                    children: [
                      Text('¿Estás seguro de que deseas eliminar esta imagen?'),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: isLocal
                              ? Image.file(
                                  File(imageToDelete.image),
                                  fit: BoxFit.cover,
                                  width: 130,
                                  height: 130,
                                )
                              : Image.network(
                                  imageToDelete.image,
                                  fit: BoxFit.cover,
                                  width: 130,
                                  height: 130,
                                ),
                        ),
                      )

                      // ClipRRect(
                      //   child: Image.file(
                      //     imageToDelete.image,
                      //     fit: BoxFit.cover,
                      //     width: 130,
                      //     height: 130,
                      //   ),
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
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
                      if (imageToDelete.image.startsWith('http')) {
                        // La imagen es remota, añadir a eliminadas y eliminar de la lista original
                        widget.imagenesEliminadas.add(imageToDelete);
                        widget.imageUrls.remove(imageToDelete);
                      } else {
                        // La imagen es local, eliminar de la lista de nuevas imágenes
                        widget.imagenesNuevas.remove(imageToDelete);
                      }

                      // Ajustar el índice actual
                      allImages = [
                        ...widget.imageUrls,
                        ...widget.imagenesNuevas
                      ];
                      if (_currentIndex >= allImages.length - 1) {
                        _currentIndex = allImages.length - 2;
                      } else {
                        _currentIndex = 0;
                      }

                      setState(() {});

                      Navigator.of(context).pop();
                    },
                    child: Text('Eliminar'),
                  ),
                ],
              );
            });
      }
    });
  }
}
