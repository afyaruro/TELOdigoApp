void main() {
  // Fecha y hora que deseas comparar (ejemplo: 6 de junio de 2024, 14:30)
  DateTime targetDateTime = DateTime(2024, 6, 6, 14, 30);

  // Fecha y hora actual
  DateTime now = DateTime.now();

  // Verificar si la fecha objetivo ya ha transcurrido
  if (targetDateTime.isBefore(now)) {
    print('La fecha y hora han transcurrido.');
  } else {
    print('La fecha y hora aún no han transcurrido.');
  }
}