class ReporteView {
  final DateTime fecha;
  final String userAnfitrion;

  ReporteView({
    required this.fecha,
    required this.userAnfitrion,
  });

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "userAnfitrion": userAnfitrion,
      };

  factory ReporteView.fromJson(Map<String, dynamic> json) {
    return ReporteView(
      fecha: json['fecha'],
      userAnfitrion: json['userAnfitrion'],
    );
  }
}
