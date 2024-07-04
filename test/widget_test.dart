// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';

void main() {

 test('Test isReservationWithinHours', () {
    // Caso 1: El establecimiento abre y cierra dentro del mismo día
    expect(
      isReservationWithinHours(
        horaAbrir: 23,
        minutoAbrir: 10,
        horaCerrar: 10,
        minutoCerrar: 30,
        duracionReserva: 2,
      ),
      false,
    );

    expect(
      isReservationWithinHours(
        horaAbrir: 23,
        minutoAbrir: 10,
        horaCerrar: 22,
        minutoCerrar: 30,
        duracionReserva: 2,
      ),
      true,
    );


    expect(
      isReservationWithinHours(
        horaAbrir: 23,
        minutoAbrir: 10,
        horaCerrar: 23,
        minutoCerrar: 30,
        duracionReserva: 2,
      ),
      false,
    );

    expect(
      isReservationWithinHours(
        horaAbrir: 23,
        minutoAbrir: 10,
        horaCerrar: 23,
        minutoCerrar: 6,
        duracionReserva: 2,
      ),
      true,
    );

     expect(
      isReservationWithinHours(
        horaAbrir: 8,
        minutoAbrir: 10,
        horaCerrar: 4,
        minutoCerrar: 20,
        duracionReserva: 2,
      ),
      false,
    );


    expect(
      isReservationWithinHours(
        horaAbrir: 8,
        minutoAbrir: 10,
        horaCerrar: 23,
        minutoCerrar: 4,
        duracionReserva: 2,
      ),
      true,
    );

   




   
  });


}


 bool isReservationWithinHours(
      {required int horaAbrir,
      required int horaCerrar,
      required int minutoAbrir,
      required int minutoCerrar,
      required int duracionReserva}) {
    DateTime now = DateTime.now();
    DateTime abrirEstablecimiento;
    DateTime cerrarEstablecimiento;

    if (horaAbrir >= horaCerrar) {

      if (horaAbrir > horaCerrar) {

        abrirEstablecimiento =
            DateTime(now.year, now.month, now.day, horaAbrir, minutoAbrir);

        cerrarEstablecimiento = DateTime(
            now.year, now.month, now.day + 1, horaCerrar, minutoCerrar);

        if (now.hour < 24) {

          abrirEstablecimiento = DateTime(
              now.year, now.month, now.day - 1, horaAbrir, minutoAbrir);
          cerrarEstablecimiento =
              DateTime(now.year, now.month, now.day, horaCerrar, minutoCerrar);

        }
      } else if (horaAbrir == horaCerrar && minutoAbrir > minutoCerrar) {

        abrirEstablecimiento =
            DateTime(now.year, now.month, now.day, horaAbrir, minutoAbrir);

        cerrarEstablecimiento = DateTime(
            now.year, now.month, now.day + 1, horaCerrar, minutoCerrar);

        if (now.hour < 24) {

          abrirEstablecimiento = DateTime(
              now.year, now.month, now.day - 1, horaAbrir, minutoAbrir);
          cerrarEstablecimiento =
              DateTime(now.year, now.month, now.day, horaCerrar, minutoCerrar);

        }
      } else {

        abrirEstablecimiento =
            DateTime(now.year, now.month, now.day, horaAbrir, minutoAbrir);

        cerrarEstablecimiento =
            DateTime(now.year, now.month, now.day, horaCerrar, minutoCerrar);

      }
    } else {

      abrirEstablecimiento =
          DateTime(now.year, now.month, now.day, horaAbrir, minutoAbrir);

      cerrarEstablecimiento =
          DateTime(now.year, now.month, now.day, horaCerrar, minutoCerrar);

    }

    DateTime horaInicioReserva = now;
    DateTime reservationEnd =
        horaInicioReserva.add(Duration(hours: duracionReserva + 1));

    // Ajustar horaInicioReserva y reservationEnd si son antes de la hora de apertura
    if (horaInicioReserva.isBefore(abrirEstablecimiento)) {
      horaInicioReserva = abrirEstablecimiento;
      reservationEnd = horaInicioReserva.add(Duration(hours: duracionReserva));
    }

    // Verificar si la reserva está dentro del horario de apertura
    if (horaInicioReserva.isAfter(abrirEstablecimiento) &&
        reservationEnd.isBefore(cerrarEstablecimiento)) {
      return true;
    }

    return false;
  }
