part of 'app_colors.dart';

/// Class representing the dark color scheme for the application.
class AppDarkColor extends AppColor {
  static final AppDarkColor _instance = AppDarkColor._();

  factory AppDarkColor() {
    return _instance;
  }
  AppDarkColor._()
      : super(
            replyMessageContainerColor: const Color.fromARGB(255, 135, 68, 78),
            chatCommon: const Color.fromARGB(212, 242, 49, 110),
            chatSideBar: const Color(0xFFFF9AA2),
            chatTileGradientOne: const Color.fromARGB(255, 240, 93, 130),
            chatTileGradientTwo: const Color(0xFFfe526a),
            statusborder: const Color.fromARGB(255, 255, 0, 85),
            buttonWhitishBackground: const Color(0xFFFFFFFF).withOpacity(0.9),
            iconSoftColor: const Color(0xFFFF4D67),
            iconPrimaryColor: const Color(0xFFFFFFFF),
            iconSecondarycolor: const Color.fromARGB(255, 164, 164, 164),
            indicatorColor: const Color(0xFFFF4D67),
            loadingColor: const Color(0xFFFF4D67),
            choiceChipSelectedolor: const Color(0xFFFF4D67),
            background: const Color(0xFF000000),
            softBackground: const Color(0xFF292C35),
            secondaryBackground: const Color(0xFF1a1a22),
            lightBackground: const Color(0xFF2C2C2C),
            pure: const Color(0xFF000000),
            primaryText: const Color(0xFFEAEAEA),
            primaryTextSoft: const Color(0xFFf48A9A).withOpacity(0.9),
            primaryTextBlur: const Color(0xFFFFFFFF).withOpacity(0.8),
            secondaryText: const Color(0xFFA0A0A0),
            secondaryPrimaryText: const Color(0xFFFF4D67),
            buttonBackground: const Color(0xFFFF4D67),
            buttonForground: const Color(0xFFFFFFFF),
            buttonSecondaryColor: const Color(0xFFf48A9A).withOpacity(0.9),
            bottomBar: const Color(0xFF202020),
            iconColor: const Color(0xFF4E4E4E),
            gradientPrimary: const Color(0xFF4E4E4E),
            gradientSecondary: const Color(0xFF000000),
            boxShadow: const Color(0xFF414141),
            primaryBorder: const Color(0xFF3C3C3C),
            primarySoftBorder: const Color(0xFF3C3C3C).withOpacity(0.5),
            secondaryBorder: const Color(0xFF3C3C3C).withOpacity(0.3),
            progressIndicatorColor: const Color(0xFFFFFFFF),
            glassEffect: const Color(0xFF2C2C2C).withOpacity(0.3),
            danger: const Color(0xFFF44336),
            fillColor: const Color(0xFF23262f),
            userChatColor: const Color(0xFF81C784),
            recipientChatColor: const Color(0xFF1E6EBA),
            success: const Color(0xFF4CAF50),
            bottomSheet: const Color(0xFF1C1C1C),
            bottomBarColor: const Color(0xFF17203A).withOpacity(.8),
            bottomBarLowShade: const Color(0xFF17203A).withOpacity(.3));
}
