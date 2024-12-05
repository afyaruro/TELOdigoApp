import 'package:flutter_test/flutter_test.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/images.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/domain/models/usuario.dart';

import 'funcionesTest.dart';

void main() {
  test('Login Credenciales Correctas', () async {
    String resp = await Logintest.LoginTest("usuario1", "contraseña123");
    print(resp);
    expect(resp, "Credenciales Correctas");
  });

  test('Login Usuario no Encontrado', () async {
    String resp = await Logintest.LoginTest("usu", "contraseña123");
    print(resp);
    expect(resp, "El usuario no existe");
  });

  test('Login Contraseña Incorrecta', () async {
    String resp = await Logintest.LoginTest("usuario1", "contraseña1");
    print(resp);
    expect(resp, "Contraseña Incorrecta");
  });

  test('Registrar Negocio', () async {
    String resp = await FirestoreNegocios.registrarNegocio(Hoteles(
        tipoHorario: "24 Horas",
        minutoAbrir: 0,
        minutoCerrar: 0,
        estado: "Registrado",
        categorias: ["Bungalow"],
        id: "35dsdad54as54a8asd",
        calificacion: 4.5,
        saldo: 80,
        user: "yreyes",
        fotos: [
          Imagens(
              image:
                  "https://www.kayak.com.mx/news/wp-content/uploads/sites/29/2023/08/THEME_HOTEL_SIGN_FIVE_STARS_FACADE_BUILDING_GettyImages-1320779330-3.jpg"),
          Imagens(
              image:
                  "https://cf.bstatic.com/xdata/images/hotel/max1024x768/542294627.jpg?k=053c2e8105dcc76be99a9926fd743009ef9e534722b76dd6ffd5ffd96b725460&o=&hp=1"),
          Imagens(
              image:
                  "https://cf.bstatic.com/xdata/images/hotel/max1024x768/508364353.jpg?k=85b7de8df7848e106b27e4b5d093c77623731582a44003e552e160926c755564&o=&hp=1")
        ],
        servicios: ["WIFI"],
        metodosPago: ["Efectivo", "Yape"],
        direccion: "Calle 45 #65-36",
        nombre: "Las Vegas",
        tipoEspacio: "Hotel",
        habitaciones: [
          Habitaciones(
              nombre: "Simple",
              precios: [Precios(precio: 36, hora: 1)],
              cantidad: 3)
        ],
        latitud: 69.2,
        longitud: 145.2,
        horaAbrir: 0,
        horaCerrar: 0));
    print(resp);
    expect(resp, "Hotel registrado con éxito");
  });

  test('Mis Negocio', () async {
    List<Hoteles> resp = await FirestoreNegocios.obtenerListaHoteles();
    print(resp);
    expect(resp.isNotEmpty, true);
  });

  test('Registrar Usuario', () async {
    String resp = await FirestoreUsuarios.NewUsuario(
        usuario: Usuario(
            userName: "afprueba",
            password: "Afprueba20",
            nombres: "",
            apellidos: "",
            correo: "afprueba@gmail.com",
            fechaNacimiento: "20-03-1999",
            foto: "",
            modoOscuro: false,
            saldoCuenta: 0));
    print(resp);
    expect(resp, "Usuario creado exitosamente");
  });

  test('Registrar Reservar Habitacion', () async {
    String resp = await FirestoreReserva.registrarReserva(
        reserva: Reserva(
            minutoMaximoLlegada: 35,
            horaMaximaLlegada: 5,
            fecha: DateTime.now(),
            precio: 65,
            key: 1,
            idUserHotel: "asdas5as4d5as",
            metodoPago: "Efectivo",
            codigo: "545846",
            estado: "En Espera",
            nombreNegocio: "Las Vegas",
            direccion: "calle 45 #26-36",
            longitud: 694,
            latitud: 25.3,
            fotoPrincipal: "",
            tiempoReserva: 2,
            habitacion: "simple",
            horaInicioReserva: 3,
            horaFinalReserva: 5,
            minutoInicioReserva: 25,
            minutoFinalReserva: 25,
            idHotel: "sa5da5s456sda45",
            idUser: "adsad5sa5d4sa5",
            nombreCliente: "juan",
            fechaFinal: DateTime.now(),
            fechaMaximaLLegada: DateTime.now()));
    print(resp);
    expect(resp, "Reserva Registrada");
  });

  test('Mis Reservas', () async {
    List<Reserva> resp =
        await FirestoreReserva.obtenerListaReservas(userId: "adas8s5sda23q5");
    print(resp);
    expect(resp.isNotEmpty, true);
  });

  
}
