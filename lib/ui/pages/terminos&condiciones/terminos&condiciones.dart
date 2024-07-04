import 'package:flutter/material.dart';

class terminos_condiciones extends StatelessWidget {
  const terminos_condiciones({super.key});

  @override
  Widget build(BuildContext context) {
    var termino1 =
        'Por favor, lee estos términos y condiciones de uso ("Términos", "Términos y Condiciones") cuidadosamente antes de utilizar la aplicación móvil TELOdigo ("nosotros", "nuestro", "la aplicación") TELOdigo ("nosotros", "nuestro", "nosotros").';
    var termino2 =
        "Al acceder o utilizar la aplicación de cualquier manera, estás de acuerdo con estos Términos y Condiciones. Si no estás de acuerdo con alguno de los términos, no podrás utilizar la aplicación.";
    var termino3 =
        "La aplicación está estrictamente reservada para personas mayores de 18 años. Al acceder y utilizar la aplicación, el usuario declara y garantiza que tiene al menos 18 años de edad. Nos reservamos el derecho de solicitar una identificación oficial u otro tipo de documentación que verifique la edad del usuario en cualquier momento. En caso de que un usuario no cumpla con este requisito de edad, su acceso y uso de la aplicación serán terminados de inmediato y sin previo aviso.";
    var termino4 =
        "El usuario reconoce y acepta que el contenido y los servicios proporcionados por la aplicación están diseñados y destinados únicamente para adultos. La aplicación no está dirigida a menores de 18 años y no recopilamos intencionalmente información personal de personas menores de esa edad. Si llegamos a tener conocimiento de que hemos recopilado información personal de un menor de 18 años, tomaremos medidas para eliminar dicha información de nuestros registros.";
    var termino5 =
        "El usuario reconoce que es su responsabilidad exclusiva cumplir con todas las leyes y regulaciones locales relacionadas con el uso de la aplicación y la reserva de habitaciones por horas en los establecimientos afiliados. Cualquier uso no autorizado de la aplicación por parte de menores de 18 años será considerado como una violación de estos Términos y Condiciones, y nos reservamos el derecho de emprender acciones legales apropiadas en tales casos.";
    var termino6 =
        "Al utilizar la aplicación, aceptas ser el único responsable de cumplir con las leyes y regulaciones aplicables. Nos reservamos el derecho de solicitar documentación que verifique tu edad en cualquier momento.";
    var termino7 =
        "La aplicación te permite buscar y reservar habitaciones por horas en establecimientos afiliados. Toda la información proporcionada en la aplicación es solo para fines informativos y de referencia. No nos hacemos responsables de la veracidad, exactitud o legalidad de la información proporcionada por los establecimientos.";
    var termino8 =
        "La aplicación actúa únicamente como un intermediario tecnológico entre los usuarios y los establecimientos afiliados. No nos hacemos responsables de ningún inconveniente, daño, pérdida, o lesión que pueda surgir durante tu estadía en un establecimiento afiliado, incluyendo, pero no limitándose a: problemas de seguridad, problemas de salud, daños a la propiedad, o cualquier otro incidente similar. Así mismo, TELOdigo no se hace responsable de la conducta de sus usuarios, incluyendo el personal de los establecimientos y huéspedes, fuera de su control directo.";
    var termino9 =
        "Es responsabilidad exclusiva del establecimiento verificar la edad de los usuarios antes de permitirles el acceso a sus instalaciones. Nosotros no asumimos ninguna responsabilidad por la verificación de la edad de los usuarios o cualquier otro aspecto relacionado con la admisión al establecimiento.";
    var termino10 =
        "Los usuarios comprenden y aceptan que cualquier transacción realizada a través de la aplicación se realiza directamente entre el usuario y el establecimiento, y que nosotros no somos parte de dicha transacción. Por lo tanto, no nos hacemos responsables de la calidad de los servicios ofrecidos por el establecimiento, ni de cualquier incumplimiento por parte del establecimiento de sus obligaciones contractuales.";
    var termino11 =
        'Al utilizar la aplicación, los usuarios liberan de responsabilidad a TELOdigo y a sus afiliados, directores, empleados y agentes de cualquier reclamo, demanda, acción, daño, pérdida o responsabilidad que surja o esté relacionado de alguna manera con el uso de la aplicación o la estancia en un establecimiento afiliado.';
    var termino12 =
        "Los usuarios de TELOdigo se comprometen a utilizar la aplicación de manera legal y ética. Queda estrictamente prohibido el uso de TELOdigo para llevar a cabo actividades ilegales o prohibidas. Estas actividades incluyen, pero no se limitan a:";
    var termino13 =
        "a) Discriminación Ilegal: Los usuarios no pueden discriminar ilegalmente a otros usuarios en base a su raza, color, religión, género, orientación sexual, origen nacional, discapacidad, estado civil, edad u otra característica protegida por la ley.";
    var termino14 =
        "b) Acoso: Los usuarios no pueden acosar, intimidar o amenazar a otros usuarios de manera ilegal o inapropiada. Esto incluye el acoso sexual, el acoso basado en género, la intimidación cibernética y cualquier otra forma de acoso.";
    var termino15 =
        "c) Violencia: Los usuarios no pueden utilizar TELOdigo para promover o facilitar actos de violencia física o emocional contra otros usuarios o terceros.";
    var termino16 =
        "d) Trata de Personas: Los usuarios no pueden utilizar TELOdigo para participar en la trata de personas, la explotación sexual, la prostitución o cualquier otra forma de explotación humana.";
    var termino17 =
        "e) Actividades Contrarias a la Ley: Los usuarios no pueden utilizar TELOdigo para llevar a cabo actividades que violen las leyes locales, nacionales o internacionales, incluyendo pero no limitado a actividades ilegales de drogas, armas, lavado de dinero, fraude o cualquier otra actividad ilegal.";
    var termino18 =
        "Los usuarios que violen esta cláusula pueden enfrentar la suspensión o cancelación de su cuenta en TELOdigo, así como acciones legales apropiadas según corresponda.";
    var termino19 =
        "Nos reservamos el derecho de modificar estos Términos y Condiciones en cualquier momento. Las modificaciones entrarán en vigencia inmediatamente después de su publicación en la aplicación. Al continuar utilizando la aplicación después de la publicación de las modificaciones, aceptas los Términos y Condiciones modificados.";
    var termino20 =
        "Si tienes alguna pregunta sobre estos Términos y Condiciones, contáctanos en telodigoapp@gmail.com";
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Términos y Condiciones",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 29, 7, 48),
        ),
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    termino1,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: 400,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Aceptación de los Términos y Condiciones",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Uso Exclusivo para Mayores de 18 Años",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino3,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino4,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino5,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Responsabilidad del Usuario",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino6,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Uso de la Aplicación",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino7,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Exención de Responsabilidad",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino8,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino9,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino10,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino11,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Prohibición de Actividades Ilegales o Prohibidas",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino12,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino13,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino14,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino15,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino16,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino17,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino18,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Modificaciones de los Términos y Condiciones",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino19,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Contacto",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      termino20,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
