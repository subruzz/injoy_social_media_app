import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final Widget? prefixIcon;
  final String? Function(String?)? validation;
  final FocusNode? focusNode;
  final String? errorMsg;
  final bool showSuffixIcon;
  final bool showPrefixIcon;
  final int? maxLine;
  final bool? readOnly;
  final Color? errorColor;
  final Color? backgroundColor;
  final bool autoValidate;
  final BorderRadius? radius;
  final void Function(String)? onChanged;
  final void Function()? datePicker;
  const CustomTextField(
      {super.key,
      this.onChanged,
      this.backgroundColor,
      this.controller,
      this.autoValidate = true,
      this.maxLine,
      this.radius,
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
            enabledBorder: OutlineInputBorder(
              borderRadius: widget.radius ?? AppBorderRadius.small,
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: widget.radius ?? AppBorderRadius.small,
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            fillColor: AppDarkColor().secondaryBackground,
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
                    icon: CustomSvgIcon(
                        height: 20,
                        width: 20,
                        assetPath: widget.obsecureText
                            ? isPassWordVisible
                                ? AppAssetsConst.visibilityOff
                                : AppAssetsConst.visibility
                            : AppAssetsConst.calendar))
                : null,
            // Icon(widget.obsecureText
            //     ? isPassWordVisible
            //         ? Icons.visibility_outlined
            //         : Icons.visibility_off_outlined
            //     : Icons.calendar_month_outlined),
            // )
            // : null,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText),
        validator: widget.validation,
        autovalidateMode:
            widget.autoValidate ? AutovalidateMode.onUserInteraction : null);
  }
}
