import 'package:flutter/material.dart';

import '../constants/enums/enums.dart';

class BaseTextField extends StatefulWidget {
  final TextFieldType textFieldType;
  final Function(String value) onChanged;
  final String? hintText;

  const BaseTextField({
    required this.textFieldType,
    required this.onChanged,
    this.hintText,
  });

  @override
  _BaseTextFieldState createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _isObscureText = false;

  @override
  void initState() {
    super.initState();
    _isObscureText = widget.textFieldType == TextFieldType.password;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: _controller,
      obscureText: _isObscureText,
      style: const TextStyle(
        //color: AppColors.white,
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        prefixIcon: _getPrefixIcon(),
        suffixIcon: widget.textFieldType == TextFieldType.password
            ? IconButton(
                icon: Icon(
                  _isObscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  //color: AppColors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isObscureText = !_isObscureText;
                  });
                },
              )
            : SizedBox(),
        enabledBorder: _textFieldBorder(),
        focusedBorder: _textFieldBorder(),
        border: _textFieldBorder(),
        hintText: widget.hintText ?? _getHintText(),
        hintStyle: const TextStyle(
          //color: AppColors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      
      keyboardType: _getKeyboardType(),
    );
  }

  Widget _getPrefixIcon() {
    switch (widget.textFieldType) {
      case TextFieldType.name:
        return Icon(Icons.account_circle_outlined);
      case TextFieldType.email:
        return Icon(Icons.email_outlined);
      case TextFieldType.password:
        return Icon(Icons.lock_outlined);
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.textFieldType) {
      case TextFieldType.name:
        return TextInputType.name;
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.password:
        return TextInputType.text;
    }
  }

  UnderlineInputBorder _textFieldBorder() {
    return UnderlineInputBorder(
        borderSide: BorderSide(
      width: 0.5,
      //color: AppColors.white,
    ));
  }

  String _getHintText() {
    switch (widget.textFieldType) {
      case TextFieldType.name:
        return "Name";
      case TextFieldType.email:
        return "E-Mail";
      case TextFieldType.password:
        return "Password";
    }
  }
}
