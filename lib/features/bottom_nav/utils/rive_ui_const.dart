part of '../presentation/pages/bottom_nav.dart';

final List<SMIBool> _riveIconInputs = [];
final List<StateMachineController?> _controllers = [];
List<Widget> getScreens({bool isWeb = false}) {
  List<Widget> pages = [
    const HomePage(),
    const ExplorePageBuilder(),
    isWeb ? const VideosPageWeb() : const VideoReelPage(),
    isWeb ? const ChatWebScreen() : const ChatMainTabPage(),
    const ProfilePageWrapper()
  ];
  return pages;
}

void animateTheIcon(int index) {
  _riveIconInputs[index].change(true);
  Future.delayed(
    const Duration(seconds: 1),
    () {
      _riveIconInputs[index].change(false);
    },
  );
}
