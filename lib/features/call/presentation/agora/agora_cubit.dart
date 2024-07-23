// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/const/agora_config.dart';

// part 'agora_state.dart';

// class AgoraCubit extends Cubit<AgoraState> {
//   static final AgoraCubit _instance = AgoraCubit._instance;
//   AgoraClient? _client;
//   AgoraCubit._internal() : super(AgoraInitial());
//   AgoraClient? get getAgoraClient => _client;

//   Future<void> initialize({String? tokenUrl, String? channelName}) async {
//     if (_client == null) {
//       _client = AgoraClient(
//         agoraConnectionData: AgoraConnectionData(
//           appId: AgoraConfig.agoraAppId,
//           channelName: channelName!,
//           tokenUrl: tokenUrl,
//         ),
//       );
//       await _client!.initialize();
//     }
//   }

//   Future<void> leaveChannel() async {
//     if (_client != null) {
//       await _client!.engine.leaveChannel();
//       await _client!.engine.release();
//       _client = null; // Reset the client
//     }
//   }

//   AgoraCubit() : super(AgoraInitial());
// }
