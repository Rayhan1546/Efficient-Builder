import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldType { email, password, number, text }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String textFieldName;
  final String? errorText;
  final bool? enable;
  final ValueChanged<String>? onChanged;
  final TextFieldType textFieldType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.textFieldName,
    this.errorText,
    this.enable = true,
    this.onChanged,
    this.textFieldType = TextFieldType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  final Color _primaryColor = const Color(0xFF6200EE);
  final Color _labelColor = const Color(0xFF666666);
  final Color _errorColor = const Color(0xFFB00020);
  final Color _textColor = const Color(0xFF121212);
  final Color _borderColor = const Color(0xFFE0E0E0);
  final Color _focusedBorderColor = const Color(0xFF6200EE);

  TextInputType _getKeyboardType() {
    switch (widget.textFieldType) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.password:
      case TextFieldType.text:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (widget.textFieldType) {
      case TextFieldType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enable,
      obscureText: widget.textFieldType == TextFieldType.password
          ? !_isPasswordVisible
          : false,
      onChanged: widget.onChanged,
      keyboardType: _getKeyboardType(),
      inputFormatters: _getInputFormatters(),
      decoration: InputDecoration(
        labelText: widget.textFieldName,
        labelStyle: TextStyle(
          color: widget.enable == false ? Colors.grey : _labelColor,
          fontSize: 16,
        ),
        errorText: widget.errorText,
        errorStyle: TextStyle(
          color: _errorColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: widget.textFieldType == TextFieldType.password
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: widget.enable == false ? Colors.grey : _labelColor,
                ),
                onPressed: widget.enable == false
                    ? null
                    : () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _focusedBorderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _errorColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        filled: true,
        fillColor: widget.enable == false ? Colors.grey.shade100 : Colors.white,
      ),
      style: TextStyle(
        fontSize: 16,
        color: widget.enable == false ? Colors.grey : _textColor,
      ),
      cursorColor: _primaryColor,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
    );
  }
}
