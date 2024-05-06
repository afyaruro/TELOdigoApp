// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreditCardUI extends StatelessWidget {
  String num;
  String name;
  int month;
  int year;
  String method;
  CreditCardUI({
    this.num = "XXXX",
    this.name = "Empyt Person",
    this.month = 0,
    this.year = 0,
    this.method = "",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<List<String>> images = [
      ['debvisa', "assets/visa.png"],
      ['visa', "assets/visa.png"],
      ['debmaster', "assets/master-2.png"],
      ['master', "assets/master-2.png"],
    ];
    String imageIcon() {
      for (var icon in images) {
        if (icon[0] == method) {
          print(icon[1]);
          return icon[1];
        }
      }
      return "";
    }
    masterText(){
      if(method == "master" || method == "debmaster"){
        return true;
      }else{
        return false;
      }
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 12,
      shadowColor: Color.fromARGB(255, 190, 160, 209),
      child: Container(
        width: MediaQuery.of(context).size.width * .85,
        height: 220,
        decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromARGB(255, 190, 160, 209), width: 1),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff3B2151),
              Color.fromARGB(255, 156, 110, 187),
              //Color.fromARGB(255, 190, 160, 209),
              //Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            alignment: const Alignment(0, 0),
            children: [
              Align(
                alignment: const Alignment(-.9, -.9),
                child:
                    Image.asset("assets/sim-card-3.png", width: 50, height: 50,),
              ),
              Align(
                alignment: const Alignment(.9, -1),
                child: Image.asset(imageIcon(), width: 60, height: 60,color: Color(0xffffffff),),
              ),
              Visibility(
                visible: masterText(),
                child: Align(
                  alignment: Alignment(.88, -.46),
                  child: Text(
                    "MasterCard",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(-.25, .1),
                child: Text(
                  "XXXX XXXX XXXX $num",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Align(
                alignment: Alignment(-.8,.9),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Align(
                alignment: Alignment(.9, .9),
                child: Text(
                  month == 0 ? "MM/YY" : "$month/$year",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
