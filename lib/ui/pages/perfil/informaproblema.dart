import 'package:flutter/material.dart';

class InformaProblema extends StatefulWidget {
  const InformaProblema({super.key});

  @override
  State<InformaProblema> createState() => _InformaProblemaState();
}

class _InformaProblemaState extends State<InformaProblema> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        title: Text(
          "Informa un problema",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 221, 219, 219),
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                // controller: _controller,
                maxLines: null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Escribe aquí...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
