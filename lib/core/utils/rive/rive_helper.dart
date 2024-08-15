import 'package:rive/rive.dart';
import 'package:social_media_app/core/utils/rive/model.dart';

class RiveHelper {
  static void riveOnInIt(Artboard artboard,
      {required String stateMachineName,
      required List<StateMachineController?> controllers,
      required List<SMIBool> riveIconInputs}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);
    controllers.add(controller);

    riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  }

  static List<RiveModel> bottomNavItems = [
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "TIMER",
        stateMachineName: "TIMER_Interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "CHAT",
        stateMachineName: "CHAT_Interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ];
}
