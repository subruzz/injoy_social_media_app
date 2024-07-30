import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/elevated_button_theme.dart';
import 'package:social_media_app/core/theme/widget_themes/floating_action_theme.dart';
import 'package:social_media_app/core/theme/widget_themes/text_field_theme.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';

/// Defines the dark theme for the application.
final class AppDarkTheme {
  static final AppDarkColor _color = AppDarkColor();

  /// Dark theme configuration.
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppDarkColor().background,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.dark(
      surface: _color.background,
    ),
    elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonTheme,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          _color.primaryTextSoft,
        ),
        overlayColor: WidgetStatePropertyAll(
          _color.glassEffect,
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      overlayColor: WidgetStatePropertyAll(_color.primaryText),
        trackOutlineWidth: const WidgetStatePropertyAll(2),
        trackOutlineColor: WidgetStatePropertyAll(_color.secondaryBackground),
        thumbColor: WidgetStatePropertyAll(
          _color.primaryText,
        ),
        trackColor: WidgetStatePropertyAll(_color.background)),
    textTheme: AppTextTheme.appTextTheme,

    chipTheme: ChipThemeData(
        shape: const StadiumBorder(
          side: BorderSide(style: BorderStyle.none),
        ),
        selectedColor: _color.choiceChipSelectedolor,
        backgroundColor: _color.secondaryBackground),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    dividerTheme: DividerThemeData(color: _color.secondaryBackground),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: _color.background,
      foregroundColor: _color.primaryText,
    ),
    // navigationBarTheme: NavigationBarThemeData(
    //   backgroundColor: _color.bottomBar,
    //   elevation: 0,
    //   labelTextStyle: WidgetStateProperty.resolveWith((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return TextStyle(color: _color.primaryText, fontSize: 12.sp);
    //     } else {
    //       return TextStyle(
    //         color: _color.secondaryText,
    //         fontSize: 12.sp,
    //       );
    //     }
    //   }),
    //   iconTheme: WidgetStateProperty.resolveWith((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return IconThemeData(
    //         color: _color.background,
    //       );
    //     } else {
    //       return IconThemeData(
    //         color: _color.secondaryText,
    //       );
    //     }
    //   }),
    //   indicatorColor: _color.primaryText,
    // ),

    inputDecorationTheme: AppTextFieldTheme.textFieldTheme,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: _color.boxShadow,
        cursorColor: _color.primaryText,
        selectionHandleColor: _color.primaryText),
    drawerTheme: DrawerThemeData(
      backgroundColor: _color.background,
      surfaceTintColor: Colors.transparent,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: _color.iconColor,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: _color.progressIndicatorColor,
    ),
    dialogBackgroundColor: _color.softBackground,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
      backgroundColor: _color.softBackground,
      surfaceTintColor: Colors.transparent,
    ),
    dividerColor: Colors.red,
    popupMenuTheme: PopupMenuThemeData(
      color: _color.softBackground,
      shadowColor: _color.softBackground,
      surfaceTintColor: _color.softBackground,
      elevation: 10,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: _color.bottomSheet,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    tabBarTheme: TabBarTheme(
      labelPadding: const EdgeInsets.only(bottom: 6),
      labelColor: _color.secondaryPrimaryText,
      labelStyle: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
      ),
      unselectedLabelStyle: TextStyle(
        color: _color.secondaryText,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: _color.secondaryBackground,
      indicatorColor: _color.buttonBackground,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      textColor: _color.primaryText,
      backgroundColor: _color.softBackground,
      iconColor: _color.iconColor,
      collapsedBackgroundColor: _color.softBackground,
      collapsedTextColor: _color.primaryTextSoft,
      collapsedIconColor: _color.primaryTextSoft,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    floatingActionButtonTheme:
        AppFloationActionButtonTheme.floatingActionButtonTheme,
    sliderTheme: SliderThemeData(
      activeTickMarkColor: _color.success,
      activeTrackColor: _color.success,
      inactiveTrackColor: _color.secondaryBorder,
      thumbColor: _color.success,
      allowedInteraction: SliderInteraction.tapAndSlide,
    ),
  );
}
