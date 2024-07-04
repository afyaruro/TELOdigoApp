class Reporte {
  final int numeroReservas;
  final String userAnfitrion;

  Reporte({
    required this.numeroReservas,
    required this.userAnfitrion,
  });

  Map<String, dynamic> toJson() => {
        "numeroReservas": numeroReservas,
        "userAnfitrion": userAnfitrion,
      };

  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      numeroReservas: json['numeroReservas'],
      userAnfitrion: json['userAnfitrion'],
    );
  }
}
