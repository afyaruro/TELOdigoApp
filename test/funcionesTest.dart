import 'dart:async';

import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/domain/models/usuario.dart';

class Logintest {
  static Usuario? usuario;
  static final UserController controlleruser = Get.find();

  // Lista local de usuarios "quemados" con sus contraseñas.
  static final List<Map<String, dynamic>> usuariosLocal = [
    {
      "userName": "usuario1",
      "password": "contraseña123",
      "nombre": "Usuario Uno",
    },
    {
      "userName": "usuario2",
      "password": "contraseña456",
      "nombre": "Usuario Dos",
    },
    // Agrega más usuarios según sea necesario
  ];

  // Método de login usando la lista local de usuarios.
  static Future<String> LoginTest(String user, String pass) async {
    var resp = await buscarUsuarioTest(user);

    if (resp == "exist") {
      if (usuario?.password == pass) {
        return "Credenciales Correctas";
      } else {
        return "Contraseña Incorrecta";
      }
    } else {
      return "El usuario no existe";
    }
  }

  // Método que simula la búsqueda de un usuario en la lista local.
  static Future<String> buscarUsuarioTest(String userName) async {
    try {
      // Busca el usuario en la lista local
      var userFound = usuariosLocal.firstWhere(
        (user) => user['userName'] == userName,
        orElse: () => {},
      );

      if (userFound.isNotEmpty) {
        // Simula la creación del objeto Usuario con los datos encontrados
        usuario = Usuario(
            userName: userFound['userName'],
            password: userFound['password'],
            apellidos: "",
            correo: "",
            fechaNacimiento: "",
            foto: "",
            modoOscuro: false,
            nombres: "",
            saldoCuenta: 0);
        return "exist";
      } else {
        return "no-exist";
      }
    } catch (error) {
      return "error";
    }
  }
}

class FirestoreNegocios {
  static List<Hoteles> listaHoteles = [
    Hoteles(
      id: '1',
      nombre: 'Hotel Mar Azul',
      tipoEspacio: 'Hotel',
      habitaciones: [],
      direccion: 'Av. Mar Azul, 123',
      tipoHorario: '24 horas',
      horaAbrir: 8,
      horaCerrar: 22,
      minutoAbrir: 0,
      minutoCerrar: 0,
      longitud: -74.0060,
      latitud: 40.7128,
      metodosPago: ['Tarjeta', 'Efectivo'],
      servicios: ['Wifi', 'Restaurante'],
      categorias: ['4 Estrellas'],
      fotos: [],
      user: 'user1',
      saldo: 1000.0,
      calificacion: 4.2,
      estado: 'Activo',
    ),
    Hoteles(
      id: '2',
      nombre: 'Hotel Sol',
      tipoEspacio: 'Hotel',
      habitaciones: [],
      direccion: 'Calle Sol, 456',
      tipoHorario: '24 horas',
      horaAbrir: 9,
      horaCerrar: 23,
      minutoAbrir: 0,
      minutoCerrar: 0,
      longitud: -73.9876,
      latitud: 40.7306,
      metodosPago: ['Tarjeta'],
      servicios: ['Spa', 'Gimnasio'],
      categorias: ['5 Estrellas'],
      fotos: [],
      user: 'user2',
      saldo: 1200.0,
      calificacion: 4.5,
      estado: 'Activo',
    ),
    Hoteles(
      id: '3',
      nombre: 'Hotel Luna',
      tipoEspacio: 'Hostal',
      habitaciones: [],
      direccion: 'Calle Luna, 789',
      tipoHorario: 'Horario restringido',
      horaAbrir: 10,
      horaCerrar: 20,
      minutoAbrir: 0,
      minutoCerrar: 0,
      longitud: -73.9857,
      latitud: 40.7301,
      metodosPago: ['Efectivo'],
      servicios: ['Desayuno', 'Wifi'],
      categorias: ['2 Estrellas'],
      fotos: [],
      user: 'user3',
      saldo: 800.0,
      calificacion: 3.8,
      estado: 'Activo',
    ),
    Hoteles(
      id: '4',
      nombre: 'Hotel Oceano',
      tipoEspacio: 'Resort',
      habitaciones: [],
      direccion: 'Playa del Sol, 123',
      tipoHorario: '24 horas',
      horaAbrir: 7,
      horaCerrar: 23,
      minutoAbrir: 30,
      minutoCerrar: 0,
      longitud: -75.0160,
      latitud: 38.7128,
      metodosPago: ['Tarjeta', 'Transferencia'],
      servicios: ['Piscina', 'Restaurante', 'Bar'],
      categorias: ['5 Estrellas'],
      fotos: [],
      user: 'user4',
      saldo: 1500.0,
      calificacion: 4.9,
      estado: 'Activo',
    ),
    Hoteles(
      id: '5',
      nombre: 'Hotel Montaña',
      tipoEspacio: 'Cabañas',
      habitaciones: [],
      direccion: 'Montaña Alta, 234',
      tipoHorario: 'Horario restringido',
      horaAbrir: 11,
      horaCerrar: 19,
      minutoAbrir: 0,
      minutoCerrar: 0,
      longitud: -76.0460,
      latitud: 39.7120,
      metodosPago: ['Efectivo', 'Transferencia'],
      servicios: ['Wifi', 'Caminatas', 'Restaurante'],
      categorias: ['3 Estrellas'],
      fotos: [],
      user: 'user5',
      saldo: 950.0,
      calificacion: 4.0,
      estado: 'Activo',
    ),
  ];

  static Future<String> registrarNegocio(Hoteles hotel) async {
    try {
      listaHoteles.add(hotel);

      return "Hotel registrado con éxito";
    } catch (e) {
      return "Error al registrar el hotel: $e";
    }
  }

  static Future<List<Hoteles>> obtenerListaHoteles() async {
    return listaHoteles;
  }
}

class FirestoreUsuarios {
  static Future<String> NewUsuario({required Usuario usuario}) async {
    return "Usuario creado exitosamente";
  }
}

class FirestoreReserva {
  static List<Reserva> listaReserva = [
    Reserva(
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
        fechaMaximaLLegada: DateTime.now())
  ];

  static Future<String> registrarReserva({required Reserva reserva}) async {
    try {
      listaReserva.add(reserva);

      return "Reserva Registrada";
    } catch (e) {
      return "Error al registrar la reserva: $e";
    }
  }

  static Future<List<Reserva>> obtenerListaReservas({required String userId}) async {
    return listaReserva;
  }
}
