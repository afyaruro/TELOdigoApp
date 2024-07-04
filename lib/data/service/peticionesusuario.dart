import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/usuario.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';

class PeticionesUsuario {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Usuarios");
  static final UserController controlleruser = Get.find();


  static Future<String> crearUsuario(Map<String, dynamic> usuario,
      String userName, BuildContext context, String correo) async {
    try {
      
      showDialog(
        context: context,
        barrierDismissible:
            false, 
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Creando usuario..."),
              ],
            ),
          );
        },
      );

      // Primero, verifica si el nombre de usuario ya existe
      String usuarioExiste = await buscarUsuario(userName, context);

      if (usuarioExiste == "exist") {
        // Si el usuario ya existe, muestra un mensaje de error
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return  CustomAlert(
              title: "Usuario Existente",
              text: "El usuario ya se encuentra en uso",
            );
          },
        );


        return "user_exists";
      } else if (usuarioExiste == "no-exist") {
        // Si el usuario no existe, crea el nuevo usuario


        if (await verificarCorreoUnico(correo)){
          await collection.doc("$userName").set(usuario).timeout(
          Duration(seconds: 10),
          onTimeout: () async {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return  CustomAlert(
                  title: "Error de Conexion",
                  text: "La operación ha tardado demasiado en completarse",
                );
              },
            );


            await eliminarUsuario("$userName");

            throw TimeoutException(
                "La operación ha tardado demasiado en completarse");
          },
        );

        Usuario user = Usuario.desdeDoc(usuario);
        controlleruser.DatosUser(user);

        return "create";
        } else{
          
          return "correo-invalido";
        }

        
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlert(
              title: "Error de Conexión",
              text: "Verifica tu conexión a internet",
            );
          },
        );
        return "timeout";
      }
    } catch (error) {
      print("Error al agregar usuario: $error");
      return "not_connected";
    }
  }

// Método para buscar un usuario por nombre de usuario
  static Future<String> buscarUsuario(
      String userName, BuildContext context) async {
    try {
      DocumentSnapshot document = await collection
          .doc(userName)
          .get()
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            "La operación ha tardado demasiado en completarse");
      });

      if (document.exists) {
        return "exist";
      } else {
        return "no-exist";
      }
    } catch (error) {
      Navigator.pop(context);
      print("Error al buscar usuario: $error");
      return "timeout";
    }
  }

  static Future<void> eliminarUsuario(
    String userId,
  ) async {
    try {
      await collection.doc(userId).delete();

      // print("Usuario eliminado exitosamente");
    } catch (error) {
      print("Error al eliminar usuario: $error");
    }
  }


  static Future<bool> verificarCorreoUnico(String correo) async {
    try {
      QuerySnapshot querySnapshot = await 
          collection.where('correo', isEqualTo: correo)
          .get();

      return querySnapshot.docs.isEmpty; // Si está vacío, el correo es único
    } catch (e) {
      print('Error al verificar el correo único en Firestore: $e');
      return false; // Ocurrió un error, asumimos que el correo no es único
    }
  }


}




  
