import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/// A simple Bloc observer for logging Bloc events and state transitions.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logging('onEvent', event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logging(
        'onTransition',
        '\tcurrentState=${transition.currentState}\n'
            '\tnextState=${transition.nextState}');
  }

  /// Logs messages with a timestamp.
  ///
  /// [name]: The name of the event or transition being logged.
  /// [msg]: The message or data related to the event or transition.
  void logging(String name, Object? msg) {
    log(
        '===== ${DateFormat("HH:mm:ss-dd MMM, yyyy").format(DateTime.now())}: $name\n'
        '$msg');
  }
}
