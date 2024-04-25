import 'package:flutter/material.dart';

class terminos_condiciones extends StatelessWidget {
  const terminos_condiciones({super.key});

  @override
  Widget build(BuildContext context) {
    var termino1 =
        'Aceptación de Términos: Al utilizar esta aplicación móvil ("la Aplicación"), usted acepta los siguientes términos y condiciones ("Términos"). Si no está de acuerdo con estos Términos, por favor no utilice la Aplicación.';
    var termino2 =
        "Uso de la Aplicación: La Aplicación es proporcionada para su uso personal y no comercial. Usted acepta no utilizar la Aplicación con fines ilegales o no autorizados.";
    var termino3 =
        "Reservas de Hotel: La Aplicación facilita la búsqueda y reserva de habitaciones de hotel. Sin embargo, la Aplicación no garantiza la disponibilidad de habitaciones ni la precisión de la información proporcionada por los hoteles.";
    var termino4 =
        "Precios y Pagos: Los precios mostrados en la Aplicación están sujetos a cambios y pueden no incluir impuestos y tarifas adicionales. Al realizar una reserva a través de la Aplicación, usted acepta pagar el precio total indicado, incluidos todos los impuestos y tarifas aplicables.";
    var termino5 =
        "Cancelaciones y Reembolsos: Las políticas de cancelación y reembolso varían según el hotel. Por favor, consulte los términos y condiciones específicos de cada reserva.";
    var termino6 =
        "Responsabilidad del Usuario: Usted es responsable de mantener la confidencialidad de su información de inicio de sesión y de cualquier actividad que ocurra bajo su cuenta.";
    var termino7 =
        "Propiedad Intelectual: Todos los derechos de propiedad intelectual relacionados con la Aplicación y su contenido son propiedad de sus respectivos propietarios.";
    var termino8 =
        'Limitación de Responsabilidad: La Aplicación se proporciona "tal cual" y "según disponibilidad". En ningún caso seremos responsables por daños directos, indirectos, incidentales, especiales o consecuentes que surjan del uso de la Aplicación.';
    var termino9 =
        "Modificaciones de los Términos: Nos reservamos el derecho de modificar estos Términos en cualquier momento. Se le notificará cualquier cambio en los Términos mediante la publicación de los términos modificados en la Aplicación.";
    var termino10 =
        "Ley Aplicable: Estos Términos se regirán e interpretarán de acuerdo con las leyes del país en el que está registrado el propietario de la Aplicación, sin tener en cuenta sus disposiciones sobre conflictos de leyes.";
    var termino =
        'Al utilizar esta aplicación, usted acepta estar sujeto a estos Términos y Condiciones. Si tiene alguna pregunta sobre estos términos, contáctenos en la dirección proporcionada en la Aplicación.';

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Terminos y Condiciones",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino1),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino2),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino3),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino4),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino5),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino6),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino7),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino8),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino9),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino10),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(termino),
                ),
              ],
            ),
          ),
        ));
  }
}
