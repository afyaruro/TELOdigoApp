import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/mercadopago.dart';
import 'package:telodigo/ui/pages/home/home.dart';
import 'package:telodigo/ui/pages/opciones%20anfitrion/payments_recharges.dart';

import 'payment_method.dart';

class OpcionesAnfitrion extends StatelessWidget {
  const OpcionesAnfitrion({super.key});

  @override
  Widget build(BuildContext context) {
    MercadoTransaction mt = MercadoTransaction();
    List<Hoteles> hoteles = [];
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
                      onPressed: () async {
                        var payer = await mt.getUserMercadoPago();

                        PeticionesNegocio.listNegocios().then((value) {
                          hoteles = value;
                        });
                        if (payer['payer']!=null) {
                          gotoPayRecharge(context, payer, hoteles);
                        }else{
                          print(payer['message']);
                          var payerNew = await mt.registerUserMercadoPago();
                          print(payerNew['message']);
                          gotoPayRecharge(context, payerNew, hoteles);
                        }
                        
                      },
                      child: const Column(
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
                      onPressed: () async {
                        var payer = await mt.getUserMercadoPago();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentMethod(
                                      payer: payer['payer'],
                                    )));
                      },
                      child: const Column(
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
                              builder: (context) => const HomeUser()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Column(
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

  void gotoPayRecharge(BuildContext context, payer, List<Hoteles> hoteles) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentsRecharges(
                payer: payer['payer'],
                listhotels: hoteles,
              )));
  }
}
