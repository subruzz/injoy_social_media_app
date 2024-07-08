import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final IconData? prefixIcon;
  final String? Function(String?)? validation;
  final FocusNode? focusNode;
  final String? errorMsg;
  final bool showSuffixIcon;
  final bool showPrefixIcon;
  final int? maxLine;
  final bool? readOnly;
  final Color? errorColor;
  final bool autoValidate;
  final void Function(String)? onChanged;
  final void Function()? datePicker;
  const CustomTextField(
      {super.key,
      this.onChanged,
      this.controller,
      this.autoValidate=true,
      this.maxLine,
      this.errorColor,
      this.readOnly,
      this.showPrefixIcon = true,
      this.showSuffixIcon = false,
      required this.hintText,
      this.keyboardType,
      this.obsecureText = false,
      this.prefixIcon,
      this.validation,
      this.focusNode,
      this.errorMsg,
      this.datePicker});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isPassWordVisible;
  @override
  void initState() {
    super.initState();
    isPassWordVisible = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      readOnly: widget.readOnly ?? false,
      maxLines: widget.maxLine ?? 1,
      controller: widget.controller,
      obscureText: isPassWordVisible,
      decoration: InputDecoration(
          errorStyle: TextStyle(color: widget.errorColor),
          errorText: widget.errorMsg,

          
          suffixIcon: widget.showSuffixIcon
              ? IconButton(
                  onPressed: widget.obsecureText
                      ? () {
                          widget.obsecureText
                              ? setState(
                                  () {
                                    isPassWordVisible = !isPassWordVisible;
                                  },
                                )
                              : null;
                        }
                      : widget.datePicker,
                  icon: Icon(widget.obsecureText
                      ? isPassWordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined
                      : Icons.calendar_month_outlined),
                )
              : null,
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          hintText: widget.hintText),
      validator: widget.validation,
      autovalidateMode: widget.autoValidate? AutovalidateMode.onUserInteraction:null
    );
  }
}
