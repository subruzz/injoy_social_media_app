import 'package:rive/rive.dart';
import 'package:social_media_app/core/utils/rive/model.dart';

/// A utility class for managing Rive animations in the application.
class RiveHelper {
  /// Initializes a Rive animation state machine on the given artboard.
  ///
  /// This method sets up the specified state machine and adds the controller
  /// to the artboard.
  ///
  /// [artboard]: The artboard where the state machine will be applied.
  /// [stateMachineName]: The name of the state machine to initialize.
  /// [controllers]: A list to store state machine controllers.
  /// [riveIconInputs]: A list to store boolean inputs for Rive animations.
  static void riveOnInIt(
    Artboard artboard, {
    required String stateMachineName,
    required List<StateMachineController?> controllers,
    required List<SMIBool> riveIconInputs,
  }) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);
    controllers.add(controller);

    riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  }

  /// A list of RiveModel instances representing bottom navigation items.
  ///
  /// Each item contains the source of the Rive file, the artboard name,
  /// and the corresponding state machine name for interactivity.
  static List<RiveModel> bottomNavItems = [
    RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
    ),
    RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
    ),
    RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
    ),
    RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
    ),
    RiveModel(
      src: "assets/animated-icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
    ),
  ];
}
