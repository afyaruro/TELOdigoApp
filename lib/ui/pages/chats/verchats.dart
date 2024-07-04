import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/mensajesHotel.dart';
import 'package:telodigo/ui/pages/chats/customChatComponent.dart';
import 'package:telodigo/ui/pages/chats/viewchatanfitrion.dart';

class VerChats extends StatefulWidget {
  const VerChats({Key? key}) : super(key: key);

  @override
  _VerChatsState createState() => _VerChatsState();
}

class _VerChatsState extends State<VerChats> {
  static final UserController controlleruser = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 7, 48),
      appBar: buildAppBar(),
      body: ListChats(),
    );
  }

  Widget ListChats() {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Chats')
            .where('idPropietarioNegocio',
                isEqualTo: controlleruser.usuario!.userName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Text(
              'Cargando Chats...',
              style: TextStyle(color: Colors.white),
            ));

            // return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<DocumentSnapshot> sortedDocs = snapshot.data!.docs.toList();

            sortedDocs.sort((a, b) {
              DateTime fechaA = a['fecha'].toDate();
              DateTime fechaB = b['fecha'].toDate();
              return fechaB.compareTo(fechaA);
            });

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (DocumentSnapshot document in sortedDocs)
                    CustomChat(document),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            );
          }
          return Center(
              child: Text(
            'No tienes chats',
            style: TextStyle(color: Colors.white),
          ));
        },
      ),
    );
  }

  Widget CustomChat(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    MensajesHotel chat = MensajesHotel.fromJson(data);

    return CustomChatComponent(
        chat: chat,
        press: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewChatAnfitrion(
                        chat: chat,
                      )));
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 29, 7, 48),
      automaticallyImplyLeading: false,
      title: const Text(
        "Chats",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
