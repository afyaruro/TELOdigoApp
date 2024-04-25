import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  const CustomDatePicker({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _currentSelectedDate;

  Future<DateTime?> _getDatePickerWidget() async {
    return showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(data: ThemeData.fallback(), child: child!);
      },
    );
  }

  void _callDatePicker() async {
    var selectedDate = await _getDatePickerWidget();
    if (selectedDate != null) {
      setState(() {
        _currentSelectedDate = selectedDate;
      });
      widget.controller.text =
          "${_currentSelectedDate!.toLocal().toIso8601String().split('T')[0]}";
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 50,
      width: 400,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 255, 255, 255),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.white,
          onTap: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(Duration(milliseconds: 300), () {
              _callDatePicker();
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(
                    "${widget.controller.text}",
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class CustomDatePicker1 extends StatefulWidget {
  final TextEditingController controller;
  const CustomDatePicker1({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomDatePicker1State createState() => _CustomDatePicker1State();
}

class _CustomDatePicker1State extends State<CustomDatePicker1> {
  DateTime? _currentSelectedDate;

  Future<DateTime?> _getDatePickerWidget() async {
    return showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(data: ThemeData.fallback(), child: child!);
      },
    );
  }

  void _callDatePicker() async {
    var selectedDate = await _getDatePickerWidget();
    if (selectedDate != null) {
      setState(() {
        _currentSelectedDate = selectedDate;
      });
      widget.controller.text =
          "${_currentSelectedDate!.toLocal().toIso8601String().split('T')[0]}";
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 50,
      width: 400,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(190, 0, 0, 0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.white,
          onTap: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(Duration(milliseconds: 300), () {
              _callDatePicker();
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(
                    "${widget.controller.text}",
                    style: const TextStyle(color: Color.fromARGB(190, 0, 0, 0), fontSize: 13),
                  ),
                const Icon(
                  Icons.calendar_month,
                  color: Color.fromARGB(190, 0, 0, 0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
