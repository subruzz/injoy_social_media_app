import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/core/const/app_radius.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/floating_action_theme.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';

/// Defines the dark theme for the application.
final class AppDarkTheme {
  static final AppDarkColor _color = AppDarkColor();

  static final _outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: _color.primaryText.withOpacity(0.3)),
    borderRadius: BorderRadius.circular(AppRadius.borderRadius),
  );

  /// Dark theme configuration.
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppDarkColor().background,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.dark(
      surface: _color.background,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _color.buttonBackground,
        foregroundColor: _color.buttonForground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: Size(50.sp, 50.sp),
        maximumSize: Size(500.sp, 100.sp),
        animationDuration: const Duration(milliseconds: 200),
      ),
    ),
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

    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppDarkColor().fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: _outlineInputBorder,
      errorBorder: _outlineInputBorder,
      focusedErrorBorder: _outlineInputBorder,
      errorStyle: TextStyle(
        color: _color.primaryTextSoft,
      ),
      counterStyle: TextStyle(
        color: _color.primaryTextBlur,
      ),
      hintStyle: TextStyle(color: _color.secondaryText, fontSize: 12.sp),
    ),
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
      backgroundColor: _color.softBackground,
      surfaceTintColor: Colors.transparent,
    ),
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
      labelStyle: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
      ),
      unselectedLabelStyle: TextStyle(
        color: _color.secondaryText,
        fontSize: 16.sp,
      ),
      dividerColor: _color.secondaryBorder,
      indicatorColor: _color.primaryBorder,
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
