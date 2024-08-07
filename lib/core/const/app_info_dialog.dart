import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class AppInfoDialog {
  static void showInfoDialog(
      {required BuildContext context,
      required VoidCallback callBack,
      double width = double.infinity,
      List<Widget> actions = const [],
      Color? backgroundColor,
      RoundedRectangleBorder? shape,
      String? title,
      String? subtitle,
      String closeText = 'Back',
      required String buttonText}) {
    showDialog(
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
                Navigator.pop(context);
                callBack();
              },
              child: Text(
                buttonText,
              ),
            ),
          ],
        );
      },
    );
  }
}

class LanguageSelectionDialog extends StatefulWidget {
  final List<String> languages; // List of language names or codes
  final String? title;
  final String closeText;
  final String okText;
  final void Function(String) onLanguageSelected;

  const LanguageSelectionDialog({
    super.key,
    required this.languages,
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
        children: widget.languages.map((language) {
          final isSelected = _selectedLanguage == language;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isSelected
                  ? AppDarkColor().buttonBackground // Selected color
                  : AppDarkColor().secondaryBackground, // Default color
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
              widget.onLanguageSelected(language);
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
            Navigator.of(context).pop();
          },
          child: Text(widget.okText),
        ),
      ],
    );
  }
}
