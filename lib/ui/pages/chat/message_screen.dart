import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/pages/chat/body.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("hola"),
      body: const Body(),
    );
  }

  AppBar buildAppBar(String nombreNegocio) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          CircleAvatar(
            // backgroundImage: NetworkImage(),
            backgroundColor: Colors.amber,
          ),
          const SizedBox(width: 20.0 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                nombreNegocio,
                style: TextStyle(fontSize: 16),
              ),
              // Text(
              //   "Active 3m ago",
              //   style: TextStyle(fontSize: 12),
              // )
            ],
          )
        ],
      ),
    );
  }
}
