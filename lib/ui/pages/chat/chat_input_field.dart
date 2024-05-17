import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0 * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff3B2151).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20.0 / 4),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Mensaje",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 47, 11, 77),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  //aqui se envia el mensaje
                },
                icon: Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
