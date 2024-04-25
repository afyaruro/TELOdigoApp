import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/sign_in/sign_in.dart';

class PeticionesChangePassword {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Usuarios");

  static Future<void> EnviarCodigo(
      {required String destino, required String code}) async {
    final smtpServer = gmail("telodigodev@gmail.com", "rnbp jfls inmq iuaw");

    final message = Message()
      ..from = Address("telodigodev@gmail.com", "Telodigo")
      ..recipients.add(destino)
      ..subject = "Código de Verificación"
      ..text = "Tu código de verificación es: $code";

    try {
      final sendReport = await send(message, smtpServer);
      print('Mensaje enviado: ');
    } catch (e) {
      print('Error al enviar el mensaje: $e');
    }
  }

  static Future<void> actualizarPassword(
      String correo, String nuevaPassword, BuildContext context) async {
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
              Text("Actualizando Contraseña..."),
            ],
          ),
        );
      },
    );

    try {
      QuerySnapshot querySnapshot =
          await collection.where('correo', isEqualTo: correo).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        String documentoId = document.id;

        await collection.doc(documentoId).update({
          'password': nuevaPassword,
        });

        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Contraseña Actualizada",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              content: Text("La contraseña se ha actualizado correctamente"),
              actions: [
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const sign_in()),
                    (Route<dynamic> route) => false,
                  );
                  },
                ),
              ],
            );
          },
        );
      } else {
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomAlert(
              title: "Error Correo",
              text: "No existe ningun usuario registrado con este correo",
            );
          },
        );
      }
    } catch (e) {
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomAlert(
            title: "Error",
            text: "Error al actualizar la contraseña",
          );
        },
      );
    }
  }
}
