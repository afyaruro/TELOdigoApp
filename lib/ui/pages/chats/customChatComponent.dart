import 'package:flutter/material.dart';
import 'package:telodigo/domain/models/mensajesHotel.dart';

class CustomChatComponent extends StatelessWidget {
  const CustomChatComponent({
    Key? key,
    required this.chat,
    required this.press,
  }) : super(key: key);

  final MensajesHotel chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0 * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color.fromARGB(255, 69, 128, 238),
                  child: Text(
                    chat.nombreCliente[0].toUpperCase(),
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        chat.nombreNegocio,
                        overflow: chat.nombreCliente.length > 10
                            ? TextOverflow.ellipsis
                            : null,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 181, 146, 226)),
                      ),
                    ),
                    Container(
                      child: Text(
                        chat.nombreCliente,
                        overflow: chat.nombreCliente.length > 10
                            ? TextOverflow.ellipsis
                            : null,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        chat.ultimoMensaje,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  chat.fecha.day == DateTime.now().day &&
                          chat.fecha.month == DateTime.now().month &&
                          chat.fecha.year == DateTime.now().year
                      ? Text(
                          "${chat.fecha.hour.toString().padLeft(2, '0')}:${chat.fecha.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          "${chat.fecha.day}/${chat.fecha.month}/${chat.fecha.year}",
                          style: TextStyle(color: Colors.white),
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  chat.noLeidos == "0"
                      ? Container()
                      : Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 11),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                chat.noLeidos,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
