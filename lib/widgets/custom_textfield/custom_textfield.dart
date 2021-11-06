import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/utils/extensions.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/textfield_config.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.textFieldType,
    this.textFieldKey,
    this.textFieldConfig = const TextFieldConfig(),
    this.decorationConfig = const TextFieldDecorationConfig(),
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onChanged,
    this.isCompulsory = true,
  }) : super(key: key);

  final GlobalKey<EditableTextState>? textFieldKey;
  final TextFieldType textFieldType;
  final TextFieldConfig textFieldConfig;
  final TextFieldDecorationConfig decorationConfig;
  final bool isCompulsory;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final void Function(String value)? onChanged;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller = widget.textFieldConfig.controller ??
      TextEditingController(
        text: widget.textFieldConfig.initialValue,
      );
  bool _isObscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.textFieldKey,
      maxLength: widget.textFieldConfig.maxLength,
      focusNode: widget.textFieldConfig.focusNode,
      textAlign: widget.textFieldConfig.textAlign,
      textDirection: widget.textFieldConfig.textDirection,
      style: widget.textFieldConfig.style,
      autofocus: widget.textFieldConfig.autoFocus,
      maxLines: widget.textFieldType == TextFieldType.password ? 1 : widget.textFieldConfig.maxLines,
      controller: _controller,
      autocorrect: widget.textFieldConfig.autocorrect,
      initialValue: widget.textFieldConfig.initialValue,
      cursorColor: widget.textFieldConfig.cursorColor,
      cursorHeight: widget.textFieldConfig.cursorHeight,
      cursorWidth: widget.textFieldConfig.cursorWidth,
      cursorRadius: widget.textFieldConfig.cursorRadius,
      textCapitalization: widget.textFieldType == TextFieldType.name ? TextCapitalization.words : TextCapitalization.none,
      enabled: widget.textFieldConfig.isEnabled,
      enableSuggestions: widget.textFieldConfig.enableSuggestions,
      keyboardType: _getKeyboardType(),
      obscureText: widget.textFieldType == TextFieldType.password ? _isObscureText : false,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscuringCharacter: widget.textFieldConfig.obscureCharacter,
      onSaved: widget.onSaved,
      textAlignVertical: widget.textFieldConfig.textAlignVertical,
      readOnly: widget.textFieldConfig.readOnly,
      textInputAction: widget.textFieldConfig.textInputAction,
      validator: (value) {
        return _verifyData(value);
      },
      decoration: InputDecoration(
        constraints: widget.decorationConfig.constraints,
        border: widget.decorationConfig.border,
        contentPadding: widget.decorationConfig.contentPadding,
        disabledBorder: widget.decorationConfig.disabledBorder,
        focusedBorder: widget.decorationConfig.focusedBorder ?? _getTextFieldBorder(),
        errorBorder: widget.decorationConfig.errorBorder ?? _getTextFieldBorder(isErrorType: true),
        focusedErrorBorder: widget.decorationConfig.focusedErrorBorder ?? _getTextFieldBorder(isErrorType: true),
        enabled: widget.decorationConfig.enabled,
        enabledBorder: widget.decorationConfig.enabledBorder ?? _getTextFieldBorder(),
        errorStyle: widget.decorationConfig.errorStyle,
        fillColor: widget.decorationConfig.fillColor,
        filled: widget.decorationConfig.filled,
        floatingLabelStyle: widget.decorationConfig.floatingLabelStyle,
        floatingLabelBehavior: widget.decorationConfig.floatingLabelBehavior,
        focusColor: widget.decorationConfig.focusColor,
        helperText: widget.decorationConfig.helperText,
        helperStyle: widget.decorationConfig.helperStyle,
        hintText: widget.decorationConfig.hintText,
        hintStyle: widget.decorationConfig.hintStyle,
        hintTextDirection: widget.decorationConfig.hintTextDirection,
        labelText: widget.decorationConfig.labelText,
        label: widget.decorationConfig.label,
        labelStyle: widget.decorationConfig.labelStyle,
        hoverColor: widget.decorationConfig.hoverColor,
        prefixIcon: widget.decorationConfig.prefixIcon,
        prefixIconConstraints: widget.decorationConfig.prefixIconConstraints,
        suffixIcon: widget.textFieldType == TextFieldType.password && widget.decorationConfig.showVisiblePasswordIcon
            ? IconButton(
                icon: Icon(
                  _isObscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: widget.decorationConfig.visiblePasswordIconColor ?? Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isObscureText = !_isObscureText;
                  });
                },
              )
            : null,
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.textFieldType) {
      case TextFieldType.password:
        return TextInputType.text;
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phoneNumber:
        return TextInputType.phone;
      case TextFieldType.name:
        return TextInputType.name;
      case TextFieldType.multiline:
        return TextInputType.multiline;
    }
  }

  OutlineInputBorder _getTextFieldBorder({bool isErrorType = false}) {
    var defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: isErrorType ? Colors.red : Colors.grey.shade300, width: 1.0),
    );

    return defaultBorder;
  }

  String? _verifyData(String? value) {
    if (value != null) {
      switch (widget.textFieldType) {
        case TextFieldType.password:
          return null;
        case TextFieldType.email:
          return value.validateEmail();
        case TextFieldType.phoneNumber:
          return value.validatePhoneNumber();
        case TextFieldType.name:
          return null;
        case TextFieldType.multiline:
          return null;
      }
    } else {
      return widget.isCompulsory ? 'Please fill the data of this field' : null;
    }
  }
}
