/// A model class representing a Rive animation configuration.
///
/// This class holds the necessary parameters to load and control a Rive animation.
/// 
/// Properties:
/// - [src]: The source path of the Rive file.
/// - [artboard]: The name of the artboard within the Rive file to be displayed.
/// - [stateMachineName]: The name of the state machine to control animations.
class RiveModel {
  final String src; // The source path of the Rive file.
  final String artboard; // The artboard name within the Rive file.
  final String stateMachineName; // The name of the state machine.

  /// Creates an instance of [RiveModel] with the provided parameters.
  ///
  /// [src], [artboard], and [stateMachineName] must not be null.
  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
  });
}
