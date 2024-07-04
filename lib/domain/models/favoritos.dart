class Favorito {
  final String nombre;
  final String idHotel;
  final String idUser;

  Favorito({ required this.nombre, required this.idHotel, required this.idUser, 
  });

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "idHotel": idHotel,
        "idUser": idUser,
      };

  factory Favorito.fromJson(Map<String, dynamic> json) {
    return Favorito(
      nombre: json['foto'],
      idHotel: json['idHotel'],
      idUser: json['idUser']
    );
  }
}