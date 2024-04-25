
import 'dart:async';

bool ejecutando = false;

Future<void> agregarDocumento() async {
  try {
    // Aquí agregarías tu lógica para crear el nuevo documento
    print('Agregando documento...');
    // Simulamos la espera de conexión a internet
    await Future.delayed(Duration(seconds: 2));
    print('Documento agregado correctamente');
  } catch (e) {
    print('Error al agregar el documento: $e');
  }
}

Future<void> agregarDocumentoConTimeout() async {
  if (!ejecutando) {
    ejecutando = true;

    // Establecer un temporizador de 5 segundos
    final Duration timeoutDuration = const Duration(seconds: 5);

    Timer(timeoutDuration, () {
      if (ejecutando) {
        ejecutando = false;
        print('Tiempo de espera excedido');
      }
    });

    // Agregar el documento
    await agregarDocumento();
    ejecutando = false;
  } else {
    print('Ya se está ejecutando la operación.');
  }
}