import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

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
  final void Function()? datePicker;
  const CustomTextField(
      {super.key,
      required this.controller,
      this.maxLine,
      this.readOnly,
      required this.showPrefixIcon,
      required this.showSuffixIcon,
      required this.hintText,
      this.keyboardType,
      required this.obsecureText,
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
      readOnly: widget.readOnly ?? false,
      maxLines: widget.maxLine ?? 1,
      controller: widget.controller,
      obscureText: isPassWordVisible,
      decoration: InputDecoration(
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
          filled: true,
          fillColor: AppDarkColor().fillColor,
          hintText: widget.hintText),
      validator: widget.validation,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
