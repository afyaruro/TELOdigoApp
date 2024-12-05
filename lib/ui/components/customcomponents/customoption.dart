import 'package:flutter/material.dart';
import 'package:telodigo/data/controllers/controllerDisable.dart';
import 'package:telodigo/ui/pages/sign_in/sign_in.dart';
import 'package:telodigo/ui/pages/sign_up/sign_up.dart';

Widget CustomOption(bool isLogin, context,
    {required DisableController controllerDisable}) {
  Container IsLogin(bool isLogin) {
    if (isLogin == true) {
      return Container(
        width: 250,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xffffffff))),
        child: Row(
          children: [
            Container(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  splashColor: Color.fromARGB(255, 184, 184, 184),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sign_in(
                                  disableController: controllerDisable,
                                )));
                  },
                  child: Center(
                    child: Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xffffffff),
              ),
              width: 250 / 2,
              height: 45,
            ),

            Container(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  splashColor: Color.fromARGB(255, 0, 0, 0),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sign_up(
                                  disableController: controllerDisable,
                                )));
                  },
                  child: Center(
                    child: Text(
                      "Registrate",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              width: 246 / 2,
              height: 45,
            ),
            // )
          ],
        ),
      );
    } else {
      return Container(
        width: 250,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xffffffff))),
        child: Row(
          children: [
            Container(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  splashColor: Color.fromARGB(255, 0, 0, 0),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                sign_in(disableController: controllerDisable)));
                  },
                  child: Center(
                    child: Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              width: 246 / 2,
              height: 45,
            ),
            Container(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  splashColor: Color.fromARGB(255, 184, 184, 184),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sign_up(
                                  disableController: controllerDisable,
                                )));
                  },
                  child: Center(
                    child: Text(
                      "Registrate",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xffffffff),
              ),
              width: 250 / 2,
              height: 45,
            ),
          ],
        ),
      );
    }
  }

  return IsLogin(isLogin);
}
