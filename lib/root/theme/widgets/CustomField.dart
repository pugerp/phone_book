import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utilities/validator/validation.dart';
import '../../utilities/validator/validator.dart';

class CustomeField extends StatefulWidget {
  CustomeField(
      {super.key,
      required this.controller,
      required this.inputType,
      required this.icon,
      required this.title,
      required this.validators,
      this.isFieldPassword = false});

  final TextEditingController controller;
  final TextInputType inputType;
  final IconData icon;
  final String title;
  final List<Validation> validators;
  final bool isFieldPassword;

  @override
  State<CustomeField> createState() => _CustomeFieldState();
}

class _CustomeFieldState extends State<CustomeField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText:
          widget.isFieldPassword ? !_passwordVisible : _passwordVisible,
      decoration: InputDecoration(
        suffixIcon: widget.isFieldPassword
            ? GestureDetector(
                onTap: () {
                  _passwordVisible = !_passwordVisible;
                  setState(() {});
                },
                child: Icon(_passwordVisible
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded),
              )
            : null,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon),
            4.horizontalSpace,
            Text(widget.title),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
      ),
      validator: Validator.apply<dynamic>(
        context,
        widget.validators,
      ),
    );
  }
}
