import 'package:flutter/material.dart';
import 'package:telodigo/ui/pages/home/home.dart';

class OpcionesAnfitrion extends StatelessWidget {
  const OpcionesAnfitrion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 20,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.apartment_rounded),
                          Text(
                            "Recargar Negocio",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.credit_card),
                          Text(
                            "Metodo de Pago",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const HomeUser()), 
                  (Route<dynamic> route) => false,
                );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.exit_to_app),
                          Text(
                            "Modo Invitado",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
