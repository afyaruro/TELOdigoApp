import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/usuario.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/home/home.dart';

class PeticionesDatosPersonales {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Usuarios");

  static Future<void> actualizarDatosPersonales(
      String nombres,
      String apellidos,
      String fecha,
      String foto,
      String username,
      BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Actualizando Datos..."),
            ],
          ),
        );
      },
    );

    try {
      QuerySnapshot querySnapshot =
          await collection.where('userName', isEqualTo: username).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        String documentoId = document.id;

        await collection.doc(documentoId).update({
          'apellidos': apellidos,
          'fechaNacimiento': fecha,
          'foto': foto,
          'nombres': nombres,
        });

        UserController controlleruser = Get.find();
        DocumentSnapshot documentuser = await collection.doc(username).get();

        Usuario? usuario;

        Map<String, dynamic> data = documentuser.data() as Map<String, dynamic>;
        usuario = Usuario.desdeDoc(data);
        controlleruser.DatosUser(usuario);

        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlert(
              title: "Datos Actualizados",
              text: "Sus datos personales han sido actualizados",
              function: (){
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeUser(currentIndex: 4,)));
              },
            );
          },
        );
      }
    } catch (e) {

      print(e);
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlert(
            title: "Error Imagen",
            text: "La imagen es demasiado pesada",
          );
        },
      );
    }
  }
}
