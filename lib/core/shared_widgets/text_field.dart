import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustom extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmit;
  final Function(String)? onChanged;
  final Function? onTap;
  final String? hintText;
  final Function? onTapSuffixIcon;
  final Function? onTapPrefixIcon;
  final IconData? suffixIconData;
  final IconData? prefixIconData;
  final FocusNode? focusNode;
  final Color backgroundColor;
  final Color? hintTextColor;
  final Color? cursorColor;
  final Color? textColor;
  final Color? prefixIconColor;
  final Color? sufixIconColor;
  final Widget? prefixWidget;
  final TextInputType inputType;
  final bool obscureText;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final bool borderSide;
  final String? errorText;
  final String? initialValue;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  static const Color? _textFieldThemeColor = null;

  const TextFieldCustom( {
    Key? key,
    this.readOnly = false,
    this.inputFormatters,
    this.labelText,
    this.controller,
    this.validator,
    this.onFieldSubmit,
    this.hintText,
    this.onTapSuffixIcon,
    this.suffixIconData,
    this.prefixIconData,
    this.onTapPrefixIcon,
    this.focusNode,
    this.backgroundColor = Colors.white,
    this.hintTextColor = _textFieldThemeColor,
    this.cursorColor = _textFieldThemeColor,
    this.textColor = _textFieldThemeColor,
    this.prefixIconColor = const Color(0xff5d5b6a),
    this.sufixIconColor = const Color(0xff5d5b6a),
    this.borderColor = const Color(0xff5d5b6a),
    this.prefixWidget,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.borderRadius = 10,
    this.borderSide = false,
    this.onTap,
    this.onChanged,
    this.errorText,
    this.initialValue,
    this.borderWidth = 0.2,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      initialValue: initialValue,
      onChanged: onChanged,
      onTap: () => onTap,
      obscureText: obscureText,
      keyboardType: inputType,
      focusNode: focusNode,
      validator: validator,
      cursorWidth: 1,
      cursorColor: cursorColor,
      autofocus: false,
      controller: controller,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(decoration: TextDecoration.none, color: textColor),
      onFieldSubmitted: onFieldSubmit,
      decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor,
          errorMaxLines: 3,
          hoverColor: Colors.white,
          errorText: errorText,
          labelText: labelText,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: hintTextColor, fontWeight: FontWeight.w300),
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontWeight: FontWeight.w300, color: hintTextColor),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          suffixIcon: suffixIconData == null
              ? null
              : GestureDetector(
                  onTap: () => onTapSuffixIcon,
                  child: Icon(
                    suffixIconData,
                    size: 16,
                    color: sufixIconColor,
                  ),
                ),
          prefixIcon: prefixWidget != null
              ? prefixWidget
              : prefixIconData == null
                  ? null
                  : GestureDetector(
                      onTap: () => onTapPrefixIcon,
                      child: Icon(
                        prefixIconData,
                        size: 16,
                        color: prefixIconColor,
                      ),
                    ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: borderSide == true
                ? BorderSide(
                    color: borderColor,
                  )
                : BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: borderSide == true
                ? BorderSide(color: borderColor, width: borderWidth)
                : BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: borderSide == true
                ? BorderSide(color: borderColor, width: borderWidth)
                : BorderSide.none,
          )),
      //  ),
    );
  }
}