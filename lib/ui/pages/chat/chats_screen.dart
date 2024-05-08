
import 'package:flutter/material.dart';
import 'package:telodigo/ui/pages/chat/bodychat.dart';


class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xff3B2151),
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/user_2.png"),
          ),
          label: "Profile",
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff3B2151),
      automaticallyImplyLeading: false,
      title: const Text("Chats", style: TextStyle(color: Colors.white),),
      actions: [
        IconButton(
          icon: const Icon(Icons.search,color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}
