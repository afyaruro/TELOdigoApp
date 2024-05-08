

import 'package:flutter/material.dart';
import 'package:telodigo/domain/models/Chat.dart';
import 'package:telodigo/ui/components/customcomponents/filled_outline_button.dart';
import 'package:telodigo/ui/pages/chat/message_screen.dart';

import 'chat_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
              20.0, 0, 20.0, 20.0),
          color: Color(0xff3B2151),
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Message"),
              const SizedBox(width: 20.0),
              FillOutlineButton(
                press: () {},
                text: "Active",
                isFilled: false,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessagesScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
