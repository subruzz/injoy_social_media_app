part of '../presentation/pages/bottom_nav.dart';

final List<SMIBool> _riveIconInputs = [];
final List<StateMachineController?> _controllers = [];
List<Widget> pages = [
  const HomePage(),
  const ExplorePageBuilder(),
  const VideoReelPage(),
  const ChatMainTabPage(),
  const ProfilePageWrapper()
];

void animateTheIcon(int index) {
  _riveIconInputs[index].change(true);
  Future.delayed(
    const Duration(seconds: 1),
    () {
      _riveIconInputs[index].change(false);
    },
  );
}
