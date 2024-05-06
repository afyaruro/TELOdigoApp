import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 12,
      
      shadowColor: Color.fromARGB(255, 190, 160, 209),
      child: Container(
          width: MediaQuery.of(context).size.width * .85,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color:Color.fromARGB(255, 190, 160, 209),width: 1 ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff3B2151),
                Color.fromARGB(255, 156, 110, 187),
                //Color.fromARGB(255, 190, 160, 209),
                //Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(15.0),
            
          ),child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              alignment: const Alignment(0, 0),
              children: [
                Align(
                  alignment: const Alignment(-1, -1),
                  child: Image.asset("assets/sim-card.png",
                      width: 30, height: 30),
                ),
                Align(
                  alignment: const Alignment(-1, -0),
                  child: Text(
                    "XXXX XXXX XXXX XXXX",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Align(
                  alignment: Alignment(-1, 1),
                  child: Text(
                    "Empty Person",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Align(
                  alignment: Alignment(1, 1),
                  child: Text(
                    "MM/YY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),),
    );
  }
}