import 'package:flutter/material.dart';

Widget CustomButtonsRadius(Color colorBackground, Color colorText,
    String textButton, bool border, Function action) {
  BoxDecoration IsBorder(bool border, Color colorText, Color colorBackgroun) {
    if (border == true) {
      return BoxDecoration(
        color: colorBackgroun,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: colorText,
          width: 1,
        ),
      );
    } else {
      return BoxDecoration(
          color: colorBackgroun, borderRadius: BorderRadius.circular(50));
    }
  }

 

  return Container(
      width: 400,
      height: 45,
      decoration: IsBorder(border, colorText, colorBackground),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: Colors.black54,
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 200), () {
              action();
            });
          },
          child: Center(
            child: Text(
              textButton,
              style: TextStyle(
                  color: colorText,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ));
}

Widget CustomButtonsRadius2(Color colorBackground, Color colorText,
    String textButton, bool border, double radius, Function action,) {
  BoxDecoration IsBorder(bool border, Color colorText, Color colorBackgroun) {
    if (border == true) {
      return BoxDecoration(
        color: colorBackgroun,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: colorText,
          width: 1,
        ),
      );
    } else {
      return BoxDecoration(
          color: colorBackgroun, borderRadius: BorderRadius.circular(radius));
    }
  }

 

  return Container(
      width: 400,
      height: 45,
      decoration: IsBorder(border, colorText, colorBackground),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          splashColor: Colors.black54,
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 500), () {
              action();
            });
          },
          child: Center(
            child: Text(
              textButton,
              style: TextStyle(
                  color: colorText,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ));
}

Widget CustomButtonsRadius3(Color colorBackground, Color colorText,
    String textButton, bool border, double radius, Function action, double widthB, double heightB) {
  BoxDecoration IsBorder(bool border, Color colorText, Color colorBackgroun) {
    if (border == true) {
      return BoxDecoration(
        color: colorBackgroun,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: colorText,
          width: 1,
        ),
      );
    } else {
      return BoxDecoration(
          color: colorBackgroun, borderRadius: BorderRadius.circular(radius));
    }
  }

 

  return Container(
      width: widthB,
      height: heightB,
      decoration: IsBorder(border, colorText, colorBackground),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          splashColor: Colors.black54,
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 500), () {
              action();
            });
          },
          child: Center(
            child: Text(
              textButton,
              style: TextStyle(
                  color: colorText,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ));
}

Widget CustomButtonsRadius4(Color colorBackground, Color colorText,
    String textButton, bool border, Function action) {
  BoxDecoration IsBorder(bool border, Color colorText, Color colorBackgroun) {
    if (border == true) {
      return BoxDecoration(
        color: colorBackgroun,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: colorText,
          width: 1,
        ),
      );
    } else {
      return BoxDecoration(
          color: colorBackgroun, borderRadius: BorderRadius.circular(50));
    }
  }

 

  return Container(
      width: 400,
      height: 45,
      decoration: IsBorder(border, colorText, colorBackground),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: Colors.black54,
          onTap: (){
            action();
          },
          child: Center(
            child: Text(
              textButton,
              style: TextStyle(
                  color: colorText,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ));
}

Widget CustomButtonsRadius5(Color colorBackground, Color colorText,
    String textButton, bool border, Function action,double width,
      double height,double fontSize,) {
  BoxDecoration IsBorder(bool border, Color colorText, Color colorBackgroun) {
    if (border == true) {
      return BoxDecoration(
        color: colorBackgroun,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: colorText,
          width: 1,
        ),
      );
    } else {
      return BoxDecoration(
          color: colorBackgroun, borderRadius: BorderRadius.circular(50));
    }
  }

 

  return Container(
      width: width,
      height: height,
      decoration: IsBorder(border, colorText, colorBackground),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: Colors.black54,
          onTap: (){
            action();
          },
          child: Center(
            child: Text(
              textButton,
              style: TextStyle(
                  color: colorText,
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ));
}