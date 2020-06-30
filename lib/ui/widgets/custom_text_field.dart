import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function onSaved;
  final int maxLines;
  final String initialValue;
  const CustomFormTextField({
    Key key,
    this.hintText,
    this.icon,
    this.onSaved,
    this.maxLines = 1,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        initialValue: initialValue ?? '',
        onSaved: onSaved,
        maxLines: maxLines,
        validator: (value) {
          if (value.isEmpty) {
            return 'Field is empty.';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
