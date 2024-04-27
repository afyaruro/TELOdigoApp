import 'package:flutter/material.dart';

import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';

class aditem extends StatefulWidget {
  final String nombre;
  final String tipoEspacio;
  final String estado;
  final String precio;

  const aditem(
      {required this.nombre,
      required this.tipoEspacio,
      this.estado = "Publicado",
      this.precio = "100.00",
      super.key});

  @override
  State<aditem> createState() => _aditemState();
}

class _aditemState extends State<aditem> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isMode = true;
  late TextEditingController hotelName;
  late TextEditingController hotelDirecction;
  late TextEditingController hoteltipo;
  List<String> habitacionesTipo = ["Simple", "Tematico"];
  Alignment _containerAlignment = const Alignment(-1, 0);
  BoxDecoration _containerBoxDecoration = BoxDecoration(
      border: Border.all(width: 3, color: Colors.white),
      borderRadius: const BorderRadius.all(Radius.circular(42.5)));
  Alignment _containerNameAlignment = const Alignment(.7, 0);
  late AnimationController _controller;
  late bool _animationCompleted = false;

  void _saveEditItem() {}

  void _cancelEditItem() {
    setState(() {
      _isMode = !_isMode;
    });
  }

  @override
  void initState() {
    super.initState();
    hotelName = TextEditingController();
    hotelDirecction = TextEditingController();
    hoteltipo = TextEditingController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animationCompleted = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _animationCompleted = false;
        });
      }
    });
  }

  void _toggleAnimation() {
    if (_isExpanded) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  void _changeDecoration() {
    setState(() {
      if (_isExpanded) {
        _containerBoxDecoration = BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius:
                const BorderRadius.all(Radius.circular(10))); // New position
      } else {
        _containerBoxDecoration = BoxDecoration(
            border: Border.all(width: 3, color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(42.5)));
      }
    });
  }

  void _moveContainer() {
    if (_isExpanded) {
      _containerAlignment = const Alignment(0, -.8);
      _containerNameAlignment = const Alignment(0, .75);
      // New position
    } else {
      _containerAlignment = const Alignment(-1, 0);
      _containerNameAlignment = const Alignment(.7, 0);
    }
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      _moveContainer();
      _changeDecoration();
      _toggleAnimation();
      // print("funcion de toggle del view mode");
      // print("isExpanded =  ${_isExpanded}");
    });
  }

  void _togleMode() {
    setState(() {
      _isMode = !_isMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width * .85,
      duration: const Duration(milliseconds: 500),
      height:
          _isExpanded ? (_isMode ? 600.0 : 700.0) : (_isMode ? 200.0 : 600.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: const Color(0xFF848484)),
      child: Padding(
        padding: _isMode
            ? const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0)
            : const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: _isMode ? viweMode(context) : editMode(context),
      ),
    );
  }

  Stack viweMode(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, 0),
      children: [
        //estado
        Align(
            alignment: const Alignment(-1, -1),
            child: SizedBox(
              width: 85,
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                        color: Color(0xFF00FF0A),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    widget.estado,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
        ),
        //Valor de la publicacion
        Align(
          alignment: const Alignment(1, -1),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500), // Adjust as needed
            curve: Curves.easeInOut, // Choose your preferred curve
            opacity: _isExpanded ? 0 : 1,
            child: SizedBox(
              width: 111,
              child: Row(
                children: [
                  const Text(
                    "S/ ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.precio,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.white30,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
        ),
        // galaria de imagenes
        Align(
          alignment: const Alignment(-1, 0),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            alignment: _containerAlignment,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: _isExpanded ? MediaQuery.of(context).size.width * .7 : 85,
              height: _isExpanded ? 200 : 85,
              decoration: _containerBoxDecoration,
              child: const Icon(Icons.photo, color: Colors.white),
            ),
          ),
        ),
        //Nombre y tipo de espacio
        Align(
          alignment: const Alignment(.7, 0),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            alignment: _containerNameAlignment,
            child: SizedBox(
              width: _isExpanded ? MediaQuery.of(context).size.width * .7 : 140,
              height:
                  _isExpanded ? MediaQuery.of(context).size.height * 0.35 : 79,
              child: Column(
                mainAxisAlignment: _isExpanded
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                crossAxisAlignment: _isExpanded
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.nombre,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : true,
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  Visibility(
                    visible: _isExpanded ? false : true,
                    child: Container(
                      width: 140,
                      height: 35,
                      decoration: const BoxDecoration(
                          color: Color(0xFFD3D3D3),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                        child: Text(
                          widget.tipoEspacio,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  //direccion
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const Text(
                      "Calle Los Colibríes 457 - Urb. Las Flores",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  //horario de atencion
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const Text(
                      "Horario de Atencion",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const SizedBox(
                      height: 5,
                    ),
                  ),
                  //horario de atencion datos
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const Text(
                      "       Todos los días                 |                24 horas",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const SizedBox(
                      height: 15,
                    ),
                  ),
                  // separador
                  Visibility(
                      visible: _isExpanded ? !_animationCompleted : false,
                      child: Container(
                        height: 5,
                        width: MediaQuery.of(context).size.width * .7,
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide.none,
                                bottom: BorderSide(color: Colors.white))),
                      )),
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const SizedBox(
                      height: 5,
                    ),
                  ),
                  //horario de atencion
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const Text(
                      "Tipo de Habitaciones",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  //horario de atencion datos
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const Text(
                      "       Simple                                 Jaccuzi\n       Tematica                                Doble",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const SizedBox(
                      height: 15,
                    ),
                  ),
                  // separador
                  Visibility(
                      visible: _isExpanded ? !_animationCompleted : false,
                      child: Container(
                        height: 5,
                        width: MediaQuery.of(context).size.width * .7,
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide.none,
                                bottom: BorderSide(color: Colors.white))),
                      )),
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const SizedBox(
                      height: 5,
                    ),
                  ),
                  //horario de atencion
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const Text(
                      "Servicios",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Visibility(
                    visible: _isExpanded ? !_animationCompleted : false,
                    child: const SizedBox(
                      height: 5,
                    ),
                  ),
                  //horario de atencion datos
                  Visibility(
                      visible: _isExpanded ? !_animationCompleted : false,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.wifi,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.tv_sharp,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.speaker_rounded,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.fastfood_sharp,
                                color: Colors.white,
                              ),
                            ]),
                      )),
                ],
              ),
            ),
          ),
        ),
        //boton de ver mas
        Align(
          alignment: const Alignment(0, 1),
          child: TextButton(
            onPressed: _toggleExpand,
            //style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.amber),minimumSize: MaterialStatePropertyAll(Size(100, 20))),
            child: Text(
              _isExpanded ? 'Ver menos' : 'Ver mas',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 2.0),
            ),
          ),
        ),
        Visibility(
          visible: _isExpanded ? true : false,
          child: Align(
            alignment: const Alignment(1, -1),
            child: TextButton(
              onPressed: _togleMode,
              //style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.amber),minimumSize: MaterialStatePropertyAll(Size(100, 20))),
              child: const Text(
                "Editar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationThickness: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack editMode(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, 0),
      children: [
        Align(
          alignment: const Alignment(0, -1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: MediaQuery.of(context).size.width * .7,
            height: 200,
            decoration: _containerBoxDecoration,
            child: const Icon(Icons.photo, color: Colors.white),
          ),
        ),
        Align(
            alignment: const Alignment(0, -.33),
            child: CustomButtonsRadius2(Colors.white, Colors.black45,
                "Actualizar Fotos", true, 5, () {})),
        Align(
            alignment: const Alignment(0, .65),
            child: SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField4(
                    controller: hotelName,
                    isPassword: false,
                    nombre: "Nombre",
                    height: 35,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField4(
                    controller: hotelDirecction,
                    isPassword: false,
                    nombre: "Direccion",
                    height: 35,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Horario de Atencion",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomComboBoxbutton(
                    data: [
                      "Horario 1",
                      "Horario 2",
                      "Horario 3",
                      "Horario.,k 4"
                    ],
                    initText: "Selecciona Servicios",
                    height: 40,
                  ),
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide.none,
                            right: BorderSide.none,
                            left: BorderSide.none,
                            bottom: BorderSide(color: Colors.white))),
                  ),
                  const Text(
                    "Tipo de Habitaciones",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomTextField4(
                              controller: hoteltipo,
                              isPassword: false,
                              nombre: "Nombre",
                              height: 35,
                              width: MediaQuery.of(context).size.width * .5,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.white,
                                size: 30,
                                weight: 2,
                                grade: 2,
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 30,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: habitacionesTipo
                                .length, // Cambia esto según tu necesidad
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:
                                    itenHabitacionTipo(habitacionesTipo[index]),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide.none,
                            right: BorderSide.none,
                            left: BorderSide.none,
                            bottom: BorderSide(color: Colors.white))),
                  ),
                  const Text(
                    "Servicios",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomComboBoxbutton(
                    data: [
                      "Servicio 1",
                      "Servicio 2",
                      "Servicio 3",
                      "Servicio 4"
                    ],
                    initText: "Selecciona Servicios",
                    height: 40,
                  )
                ],
              ),
            )),
        Align(
          alignment: Alignment(0, 1),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButtonsRadius3(Colors.white, Colors.black45, "Guardar",
                    true, 10, _saveEditItem, 90, 70),
                CustomButtonsRadius3(Colors.white, Colors.black45, "Descartar",
                    true, 10, _cancelEditItem, 90, 70)
              ],
            ),
          ),
        )
      ],
    );
  }

  IntrinsicWidth itenHabitacionTipo(String dato) {
    return IntrinsicWidth(
      child: Container(
        constraints:
            const BoxConstraints(minWidth: 0, maxWidth: double.infinity),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dato,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            IconButton(
              padding: EdgeInsets.all(0),
              icon: const Icon(
                Icons.close_rounded,
                size: 20,
              ),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// class viewmode extends StatefulWidget {
//   final String nombre;
//   final String tipoEspacio;
//   final String estado;
//   final String precio;

//   const viewmode(
//       {required this.nombre,
//       required this.tipoEspacio,
//       this.estado = "Publicado",
//       this.precio = "100.00",
//       super.key});

//   void _toggleExpand(){
//   }
//   @override
//   State<viewmode> createState() => _viewmodeState();
// }

// class _viewmodeState extends State<viewmode> {
//   Alignment _containerAlignment = const Alignment(-1, 0);
//   BoxDecoration _containerBoxDecoration = BoxDecoration(
//       border: Border.all(width: 3, color: Colors.white),
//       borderRadius: const BorderRadius.all(Radius.circular(42.5)));
//   Alignment _containerNameAlignment = const Alignment(.7, 0);

//   void _changeDecoration() {
//     setState(() {
//       if (_isExpanded) {
//         _containerBoxDecoration = BoxDecoration(
//             border: Border.all(width: 1, color: Colors.white),
//             borderRadius:
//                 const BorderRadius.all(Radius.circular(10))); // New position
//       } else {
//         _containerBoxDecoration = BoxDecoration(
//             border: Border.all(width: 3, color: Colors.white),
//             borderRadius: const BorderRadius.all(Radius.circular(42.5)));
//       }
//     });
//   }

//   void _moveContainer() {
//     if (_isExpanded) {
//       _containerAlignment = const Alignment(0, -.8);
//       _containerNameAlignment = const Alignment(0, .75);
//       New position
//     } else {
//       _containerAlignment = const Alignment(-1, 0);
//       _containerNameAlignment = const Alignment(.7, 0);
//     }
//   }
  
//   void _toggleExpand() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//       _moveContainer();
//       _changeDecoration();
//       print("funcion de toggle del view mode");
//       print("isExpanded =  ${_isExpanded}");
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return  Stack(
//           alignment: const Alignment(0, 0),
//           children: [
//             estado
//             Align(
//                 alignment: const Alignment(-1, -1),
//                 child: SizedBox(
//                   width: 85,
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 12,
//                         height: 12,
//                         decoration: const BoxDecoration(
//                             color: Color(0xFF00FF0A),
//                             borderRadius: BorderRadius.all(Radius.circular(6))),
//                       ),
//                       const SizedBox(
//                         width: 6,
//                       ),
//                       Text(
//                         widget.estado,
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 )),
  
//             Valor de la publicacion
//             Align(
//               alignment: const Alignment(1, -1),
//               child: AnimatedOpacity(
//                 duration: const Duration(milliseconds: 500), // Adjust as needed
//                 curve: Curves.easeInOut, // Choose your preferred curve
//                 opacity: _isExpanded ? 0 : 1,
//                 child: SizedBox(
//                   width: 111,
//                   child: Row(
//                     children: [
//                       const Text(
//                         "S/ ",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         widget.precio,
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       const Icon(
//                         Icons.monetization_on_outlined,
//                         color: Colors.white30,
//                         size: 30,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             galaria de imagenes
//             Align(
//               alignment: const Alignment(-1, 0),
//               child: AnimatedAlign(
//                 duration: const Duration(milliseconds: 500),
//                 alignment: _containerAlignment,
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 500),
//                   width:
//                       _isExpanded ? MediaQuery.of(context).size.width * .7 : 85,
//                   height: _isExpanded ? 200 : 85,
//                   decoration: _containerBoxDecoration,
//                   child: const Icon(Icons.photo, color: Colors.white),
//                 ),
//               ),
//             ),
//             Nombre y tipo de espacio
//             Align(
//               alignment: const Alignment(.7, 0),
//               child: AnimatedAlign(
//                 duration: const Duration(milliseconds: 500),
//                 alignment: _containerNameAlignment,
//                 child: SizedBox(
//                   width: _isExpanded
//                       ? MediaQuery.of(context).size.width * .7
//                       : 140,
//                   height: _isExpanded
//                       ? MediaQuery.of(context).size.height * 0.35
//                       : 79,
//                   child: Column(
//                     mainAxisAlignment: _isExpanded
//                         ? MainAxisAlignment.start
//                         : MainAxisAlignment.center,
//                     crossAxisAlignment: _isExpanded
//                         ? CrossAxisAlignment.start
//                         : CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         widget.nombre,
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Visibility(
//                         visible: _isExpanded ? false : true,
//                         child: const SizedBox(
//                           height: 10,
//                         ),
//                       ),
//                       Visibility(
//                         visible: _isExpanded ? false : true,
//                         child: Container(
//                           width: 140,
//                           height: 35,
//                           decoration: const BoxDecoration(
//                               color: Color(0xFFD3D3D3),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(12))),
//                           child: Center(
//                             child: Text(
//                               widget.tipoEspacio,
//                               style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ),

//                       direccion
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const Text(
//                           "Calle Los Colibríes 457 - Urb. Las Flores",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300),
//                         ),
//                       ),
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const SizedBox(
//                           height: 10,
//                         ),
//                       ),
//                       horario de atencion
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const Text(
//                           "Horario de Atencion",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const SizedBox(
//                           height: 5,
//                         ),
//                       ),
//                       horario de atencion datos
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const Text(
//                           "       Todos los días                 |                24 horas",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300),
//                         ),
//                       ),
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const SizedBox(
//                           height: 15,
//                         ),
//                       ),
//                       separador
//                       Visibility(
//                           visible: _isExpanded ? true : false,
//                           child: Container(
//                             height: 5,
//                             width: MediaQuery.of(context).size.width * .7,
//                             decoration: const BoxDecoration(
//                                 border: Border(
//                                     top: BorderSide.none,
//                                     right: BorderSide.none,
//                                     left: BorderSide.none,
//                                     bottom: BorderSide(color: Colors.white))),
//                           )),
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const SizedBox(
//                           height: 5,
//                         ),
//                       ),
//                       horario de atencion
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const Text(
//                           "Tipo de Habitaciones",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const SizedBox(
//                           height: 10,
//                         ),
//                       ),
//                       horario de atencion datos
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const Text(
//                           "       Simple                                 Jaccuzi\n       Tematica                                Doble",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300),
//                         ),
//                       ),
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const SizedBox(
//                           height: 15,
//                         ),
//                       ),
//                       separador
//                       Visibility(
//                           visible: _isExpanded ? true : false,
//                           child: Container(
//                             height: 5,
//                             width: MediaQuery.of(context).size.width * .7,
//                             decoration: const BoxDecoration(
//                                 border: Border(
//                                     top: BorderSide.none,
//                                     right: BorderSide.none,
//                                     left: BorderSide.none,
//                                     bottom: BorderSide(color: Colors.white))),
//                           )),
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const SizedBox(
//                           height: 5,
//                         ),
//                       ),
//                       horario de atencion
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const Text(
//                           "Servicios",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                       Visibility(
//                         visible: _isExpanded ? true : false,
//                         child: const SizedBox(
//                           height: 5,
//                         ),
//                       ),
//                       horario de atencion datos
//                       Visibility(
//                           visible: _isExpanded ? true : false,
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 30),
//                             child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Icon(
//                                     Icons.wifi,
//                                     color: Colors.white,
//                                   ),
//                                   Icon(
//                                     Icons.tv_sharp,
//                                     color: Colors.white,
//                                   ),
//                                   Icon(
//                                     Icons.speaker_rounded,
//                                     color: Colors.white,
//                                   ),
//                                   Icon(
//                                     Icons.fastfood_sharp,
//                                     color: Colors.white,
//                                   ),
//                                 ]),
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             boton de ver mas
//             Align(
//               alignment: const Alignment(0, 1),
//               child: TextButton(
//                 onPressed: _toggleExpand,
//                 style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.amber),minimumSize: MaterialStatePropertyAll(Size(100, 20))),
//                 child: Text(
//                   _isExpanded ? 'Ver menos' : 'Ver mas',
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       decoration: TextDecoration.underline,
//                       decorationColor: Colors.white,decorationThickness: 2.0),
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: _isExpanded ? true:false,
//               child: Align(
//                 alignment:const Alignment(1, -1.05),
//                 child: TextButton(
//                   onPressed: (){},
//                   style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.amber),minimumSize: MaterialStatePropertyAll(Size(100, 20))),
//                   child: const Text(
//                     "Editar",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         decoration: TextDecoration.underline,
//                         decorationColor: Colors.white,decorationThickness: 2.0),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
      
//   }
// }

// class ExpandableWidget extends StatefulWidget {
//   const ExpandableWidget({Key? key}) : super(key: key);

//   @override
//   _ExpandableWidgetState createState() => _ExpandableWidgetState();
// }

// class _ExpandableWidgetState extends State<ExpandableWidget> with SingleTickerProviderStateMixin{
//   bool _isExpanded = false;
//   late AnimationController _controller;
//   late Animation<double> _heightAnimation;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     _heightAnimation = Tween<double>(begin: 200, end: 500).animate(_controller);
//     _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _toggleExpand() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//       if (_isExpanded) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           height: _heightAnimation.value,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(_isExpanded ? 20 : 10),
//           ),
//           child: AnimatedOpacity(
//             opacity: _opacityAnimation.value,
//             duration: const Duration(milliseconds: 500),
//             child: Visibility(
//               visible: _isExpanded,
//               child: const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     // Add your expanded content here
//                     Text('This is the expanded content'),
//                     // ...
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         TextButton(
//           onPressed: _toggleExpand,
//           child: Text(_isExpanded ? 'Show More' :'Show Less' ),
//         ),
//       ],
//     );
//   }
// }
