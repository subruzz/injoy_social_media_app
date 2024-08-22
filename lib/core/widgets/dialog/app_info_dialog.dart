import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/languages/app_languages.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import '../../common/shared_providers/cubit/app_language/app_language_cubit.dart';

class AppInfoDialog {
  static void showInfoDialog(
      {required BuildContext context,
      required VoidCallback callBack,
      double width = double.infinity,
      List<Widget> actions = const [],
      Color? backgroundColor,
      RoundedRectangleBorder? shape,
      String? title,
      bool dismissable = false,
      String? subtitle,
      String closeText = 'Back',
      bool pop = true,
      Widget? buttonChild,
      String? buttonText}) {
    showDialog(
      barrierDismissible: dismissable,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: AppPadding.extraLarge,
          backgroundColor:
              backgroundColor ?? AppDarkColor().secondaryBackground,
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                if (title != null)
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                if (subtitle != null) AppSizedBox.sizedBox10H,
                if (subtitle != null)
                  Text(style: Theme.of(context).textTheme.bodyLarge, subtitle),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                closeText,
                style: TextStyle(color: AppDarkColor().primaryText),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (pop) Navigator.pop(context);
                  callBack();
                },
                child: buttonText != null
                    ? Text(
                        buttonText,
                      )
                    : buttonChild),
          ],
        );
      },
    );
  }
}

class LanguageSelectionDialog extends StatefulWidget {
  final String? title;
  final String closeText;
  final String okText;
  final void Function(String) onLanguageSelected;

  const LanguageSelectionDialog({
    super.key,
    required this.onLanguageSelected,
    this.title,
    this.closeText = 'Close',
    this.okText = 'Change ',
  });

  @override
  State<LanguageSelectionDialog> createState() =>
      _LanguageSelectionDialogState();
}

class _LanguageSelectionDialogState extends State<LanguageSelectionDialog> {
  String _selectedLanguage = '';
  final List<String> languages = ['English', 'Malayalam', 'Hindi'];
  @override
  void initState() {
    _selectedLanguage =
        AppLanguages.isMalayalamLocale(context) ? 'Malayalam' : 'English';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: AppPadding.extraLarge,
      backgroundColor: AppDarkColor().secondaryBackground,
      title: widget.title != null
          ? Text(
              widget.title!,
              style: Theme.of(context).textTheme.headlineLarge,
            )
          : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: languages.map((language) {
          final isSelected = _selectedLanguage == language;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isSelected
                  ? AppDarkColor().buttonBackground
                  : AppDarkColor().secondaryBackground,
              radius: 12.0,
              child: isSelected
                  ? Icon(Icons.check,
                      color: AppDarkColor().primaryText, size: 16.0)
                  : null,
            ),
            title: Text(language),
            onTap: () {
              setState(() {
                _selectedLanguage = language;
              });
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          child: Text(
            widget.closeText,
            style: TextStyle(color: AppDarkColor().primaryText),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          onPressed: () {
            context.read<AppLanguageCubit>().changeLanguage(
                Locale(_selectedLanguage == 'Malayalam' ? 'ml' : 'en'));

            Navigator.of(context).pop();
          },
          child: Text(widget.okText),
        ),
      ],
    );
  }
}
