class Usuario {
  final String userName;
  final String password;
  final String nombres;
  final String apellidos;
  final String correo;
  final String fechaNacimiento;
  final String foto;
  final bool modoOscuro;
   double saldoCuenta;

  Usuario(
      {required this.userName,
      required this.password,
      required this.nombres,
      required this.apellidos,
      required this.correo,
      required this.fechaNacimiento,
      required this.foto,
      required this.modoOscuro,
      required this.saldoCuenta,
      });

  factory Usuario.desdeDoc(Map<String, dynamic> data) {
    return Usuario(
      saldoCuenta: data['saldoCuenta'] ?? '',
      userName: data['userName'] ?? '',
      password: data['password'] ?? '',
      nombres: data['nombres'] ?? '',
      apellidos: data['apellidos'] ?? '',
      correo: data['correo'] ?? '',
      fechaNacimiento: data['fechaNacimiento'] ?? '',
      foto: data['foto'] ?? '',
      modoOscuro: data['modoOscuro'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
        "nombres": nombres,
        "apellidos": apellidos,
        "correo": correo,
        "fechaNacimiento": fechaNacimiento,
        "foto": foto,
        "modoOscuro": modoOscuro,
        "saldoCuenta": saldoCuenta
      };
}
