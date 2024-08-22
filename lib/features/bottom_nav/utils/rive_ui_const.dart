part of '../presentation/pages/bottom_nav.dart';

final List<SMIBool> _riveIconInputs = [];
final List<StateMachineController?> _controllers = [];
List<Widget> getScreens(
    {bool isWeb = false,
    FocusNode? focusNodeForExplore,
    VideoPlayerController? vdoController,
     void Function(void Function())? onPause}) {
  List<Widget> pages = [
    const HomePage(),
    ExplorePageBuilder(
      exploreFocusNode: focusNodeForExplore,
    ),
    isWeb
        ? const VideosPageWeb()
        : VideoReelPage(
            vdoController: vdoController,
            isItFromBottomBar: true,
          ),
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
