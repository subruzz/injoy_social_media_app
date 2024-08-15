import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial());
  final _connectivity = Connectivity();

  void listenToInternetConnectivity() {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.ethernet)) {
        emit(ConnectivityConnected());
        log('connected net');
      } else {
        emit(ConnectivityNotConnected());
        log('no connected net');
      }
    }).onError((error) {
      emit(ConnectivityFailure());
    });
  }
}
