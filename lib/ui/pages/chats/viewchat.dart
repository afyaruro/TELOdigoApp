import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticioneschat.dart';
import 'package:telodigo/domain/models/mensaje.dart';
import 'package:telodigo/domain/models/mensajesHotel.dart';
import 'package:telodigo/domain/models/reserva.dart';

class ViewChat extends StatefulWidget {
  final Reserva reserva;
  const ViewChat({super.key, required this.reserva});

  @override
  State<ViewChat> createState() => _ViewChatState();
}

class _ViewChatState extends State<ViewChat> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 253, 253),
      appBar: buildAppBar(widget.reserva.nombreNegocio),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              child: mensajesChat(),
            ),
            Positioned(
              child: CustomSendMensaje(),
              bottom: 0,
              left: 0,
              right: 0,
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(String nombreNegocio) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          CircleAvatar(
            backgroundImage: NetworkImage(widget.reserva.fotoPrincipal),
            backgroundColor: const Color.fromARGB(255, 223, 223, 223),
          ),
          const SizedBox(width: 20.0 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombreNegocio,
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container mensajesChat() {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Mensajes')
            .where('id',
                isEqualTo:
                    "${widget.reserva.key}") // Filtro por la reserva actual
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<DocumentSnapshot> sortedDocs = snapshot.data!.docs.toList();
            sortedDocs.sort((a, b) {
              int positionA = a['position'];
              int positionB = b['position'];

              return positionA.compareTo(positionB);
            });

            //aca hacer la actualizacion de los mensajes a visto
            PeticionesChats.ActualizarVistoCliente("${widget.reserva.key}");

            return SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (DocumentSnapshot document in sortedDocs)
                    CustomMensaje(document),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget CustomSendMensaje() {
    return Container(
        child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0 / 2,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(82, 217, 210, 238),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20.0 / 4),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Mensaje",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () async {
                          if (_messageController.text.isNotEmpty) {
                            final CollectionReference collection =
                                FirebaseFirestore.instance.collection("Chats");
                            var chatsCount = (await collection.get()).size;

                            MensajesHotel chat = MensajesHotel(
                              fecha: DateTime.now(),
                              noLeidos: "0",
                              nombreNegocio: widget.reserva.nombreNegocio,
                              ultimoMensaje: _messageController.text,
                              id: chatsCount + 1,
                              nombreCliente: widget.reserva.nombreCliente,
                              idPropietarioNegocio: widget.reserva.idUserHotel,
                              idReserva: "${widget.reserva.key}",
                            );

                            Mensaje mensaje = Mensaje(
                                id: "${chat.idReserva}",
                                type: "cliente",
                                mensaje: _messageController.text);

                            _messageController.text = "";

                            await PeticionesChats.SendChat(
                                mensaje, chat, context);
                          }
                        },
                        icon: Icon(
                          Icons.send_rounded,
                          color: Color.fromARGB(255, 53, 19, 107),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget CustomMensaje(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    if (data['type'] == "cliente") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.3,
                  top: 10,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 67, 10, 133),
                ),
                child: Text(
                  data['mensaje'],
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.visible,
                )),
          ),
          SizedBox(
            width: 2,
          ),
          data['estado'] == "Enviado"
              ? Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 209, 209, 209),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(right: 10),
                )
              : Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 25, 155, 25),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.3,
                left: 20,
                top: 10,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(73, 214, 214, 214),
              ),
              child: Text(
                data['mensaje'],
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                overflow: TextOverflow.visible,
              )),
        ),
      ],
    );
  }
}
