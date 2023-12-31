import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final bool enable;
  final bool? visible;
  final String? hint;
  final Function(String)? value;
  final TextInputType keyboardType;

  const InputWidget(
      {super.key,
      this.visible,
      required this.label,
      this.hint,
      required this.enable,
      this.value,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        enabled: enable,
        obscureText: visible ?? false,
        keyboardType: keyboardType,
        onChanged: value,
        decoration: InputDecoration(
            labelText: label,
            filled: true,
            floatingLabelStyle: TextStyle(
              color: Colors.black,
            ),
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10,
            ),
            fillColor: Color(0xFFEDEDED),
            hintText: hint,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xFFEDEDED), width: 0))),
      ),
    );
  }
}

class InputWidgetProfile extends StatelessWidget {
  final String label;
  final int? maxLines;
  const InputWidgetProfile({super.key, required this.label, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        enabled: false,
        keyboardType: TextInputType.multiline,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white, width: 0)),
          filled: true,
          fillColor: Color(0xFFEDEDED),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        ),
        controller: TextEditingController(text: label),
      ),
    );
  }
}

class inputOTP extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) value;
  final TextInputType keyboardType;

  const inputOTP(
      {super.key,
      required this.label,
      required this.hint,
      required this.value,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        keyboardType: keyboardType,
        onChanged: value,
        decoration: InputDecoration(
            labelText: label,
            filled: true,
            floatingLabelStyle: TextStyle(
              color: Colors.black,
            ),
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10,
            ),
            fillColor: Color(0xFFEDEDED),
            hintText: hint,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xFFEDEDED), width: 0))),
      ),
    );
  }
}
