class Reserva {
  final int key;
  final String codigo;
  late String estado;
  final String nombreNegocio;
  final int idHotel;
  final String idUserHotel;
  final String idUser;
  final String direccion;
  final double longitud;
  final double latitud;
  final String fotoPrincipal;
  final int tiempoReserva;
  final String habitacion;
  final int horaInicioReserva;
  final int horaFinalReserva;
  final int minutoInicioReserva;
  final int minutoFinalReserva;
  final String metodoPago;
  final double precio;
  final String nombreCliente;

  Reserva({
    required this.precio,
    required this.key,
    required this.idUserHotel,
    required this.metodoPago,
    required this.codigo,
    required this.estado,
    required this.nombreNegocio,
    required this.direccion,
    required this.longitud,
    required this.latitud,
    required this.fotoPrincipal,
    required this.tiempoReserva,
    required this.habitacion,
    required this.horaInicioReserva,
    required this.horaFinalReserva,
    required this.minutoInicioReserva,
    required this.minutoFinalReserva,
    required this.idHotel,
    required this.idUser,
    required this.nombreCliente,
  });

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "key": key,
        "nombre": nombreNegocio,
        "idHotel": idHotel,
        "idUser": idUser,
        "estado": estado,
        "direccion": direccion,
        "longitud": longitud,
        "latitud": latitud,
        "fotoPrincipal": fotoPrincipal,
        "tiempoReserva": tiempoReserva,
        "habitacion": habitacion,
        "horaInicioReserva": horaInicioReserva,
        "horaFinalReserva": horaFinalReserva,
        "minutoInicioReserva": minutoInicioReserva,
        "minutoFinalReserva": minutoFinalReserva,
        "metodoPago": metodoPago,
        "idUserHotel": idUserHotel,
        "precio": precio,
        "nombreCliente": nombreCliente
      };

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
        nombreCliente: json['nombreCliente'],
        key: json['key'],
        precio: json['precio'],
        metodoPago: json['metodoPago'],
        codigo: json['codigo'],
        nombreNegocio: json['nombre'],
        idHotel: json['idHotel'],
        idUser: json['idUser'],
        estado: json['estado'],
        direccion: json['direccion'],
        longitud: json['longitud'],
        latitud: json['latitud'],
        fotoPrincipal: json['fotoPrincipal'],
        tiempoReserva: json['tiempoReserva'],
        habitacion: json['habitacion'],
        horaInicioReserva: json['horaInicioReserva'],
        horaFinalReserva: json['horaFinalReserva'],
        minutoInicioReserva: json['minutoInicioReserva'],
        minutoFinalReserva: json['minutoFinalReserva'],
        idUserHotel: json['idUserHotel']);
  }
}
