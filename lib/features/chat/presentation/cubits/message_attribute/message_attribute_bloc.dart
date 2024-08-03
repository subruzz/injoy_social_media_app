// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:record/record.dart';
// import 'package:social_media_app/core/common/chat_utils.dart';
// import 'package:social_media_app/core/const/message_type.dart';
// import 'package:social_media_app/core/utils/id_generator.dart';
// import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
// import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
// import 'package:social_media_app/features/chat/domain/usecases/send_message_use_case.dart';
// import 'package:social_media_app/features/chat/presentation/cubits/message_info_store/message_info_store_cubit.dart';
// import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
// import 'package:video_player/video_player.dart';

// part 'message_attribute_event.dart';
// part 'message_attribute_state.dart';

// class VideoCacheManager {
//   final Map<String, VideoPlayerController> _cache = {};

//   VideoPlayerController? getController(String url) => _cache[url];

//   void cacheController(String url, VideoPlayerController controller) {
//     _cache[url] = controller;
//   }

//   Future<VideoPlayerController> initializeController(String url) async {
//     VideoPlayerController controller;
//     final cachedController = getController(url);
//     if (cachedController != null) {
//       controller = cachedController;
//     } else {
//       final file = await DefaultCacheManager().getSingleFile(url);
//       controller = VideoPlayerController.file(file);
//       controller.initialize().then((_) {
//         cacheController(url, controller);
//       });
//     }
//     return controller;
//   }
// }

// class MessageAttributeBloc
//     extends Bloc<MessageAttributeEvent, MessageAttributeState> {
//   final SendMessageUseCase _sendMessageUseCase;
//   final MessageInfoStoreCubit _infoStoreCubit;

//   MessageAttributeBloc(this._sendMessageUseCase, this._infoStoreCubit)
//       : super(MessageAttributeInitial()) {
//     on<AudioMessageClicked>(_audioMessageClicked);
//     on<AudioMessageOnGoing>(_audioMessageOnGoing);
//     on<AudioMessageStopped>(_audioMessageStopped);
//     on<TextCliked>(_textClicked);
//     on<PlayAudio>(_audioWantsToPlay);
//     on<PauseAudio>(_audioWantsToPause);
//     on<SeekAudio>(_audioSeekTo);
//     on<StopAudio>(_stopAudio);
//     on<VideoMessageClicked>(_videoMessageClicked);
//   }
//   final VideoCacheManager _videoCacheManager = VideoCacheManager();
//   final _audioRecorder = AudioRecorder();
//   final Map<String, AudioPlayer> _audioPlayers = {};
//   String? _currentPlayingAudioUrl;
//   AudioPlayer? getAudioPlayer(String url) {
//     return _audioPlayers[url];
//   }

//   StreamSubscription<Duration>? _positionSubscription;
//   StreamSubscription<PlayerState>? _playerStateSubscription;
//   Timer? _timer;
//   int _elapsedSeconds = 0;

//   Future<void> _audioMessageClicked(
//       AudioMessageClicked event, Emitter<MessageAttributeState> emit) async {
//     await initAudioRecord(audioRecorder: _audioRecorder);
//     _elapsedSeconds = 0;
//     emit(AudioStartedState());
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       _elapsedSeconds++;
//       add(AudioMessageOnGoing());
//     });
//   }

//   Future<void> _audioMessageOnGoing(
//       AudioMessageOnGoing event, Emitter<MessageAttributeState> emit) async {
//     emit(AudioOngoingState(duration: _elapsedSeconds));
//   }

//   Future<void> _audioMessageStopped(
//       AudioMessageStopped event, Emitter<MessageAttributeState> emit) async {
//     _timer?.cancel();
//     String? audioPath = await _audioRecorder.stop();
//     if (audioPath == null) return;

//     final newChat = ChatEntity(
//       senderUid: _infoStoreCubit.senderId,
//       recipientUid: _infoStoreCubit.receiverId,
//       recipientName: _infoStoreCubit.receiverName,
//       recentTextMessage: '',
//       recipientProfile: _infoStoreCubit.receiverProfile,
//       totalUnReadMessages: 0,
//       createdAt: Timestamp.now(),
//     );

//     final fileData = await File(audioPath).readAsBytes();
//     final file = File(audioPath);

//     final newMessage = MessageEntity(
//       isDeleted: false,
//       createdAt: null,
//       message: '',
//       isEdited: false,
//       assetPath: SelectedByte(
//         mediaType: MediaType.audio,
//         selectedByte: fileData,
//         selectedFile: file,
//       ),
//       deletedAt: null,
//       senderUid: _infoStoreCubit.senderId,
//       recipientUid: _infoStoreCubit.receiverId,
//       messageType: MessageTypeConst.audioMessage,
//       isSeen: false,
//       messageId: IdGenerator.generateUniqueId(),
//     );

//     emit(AudioStoppedState(duration: _elapsedSeconds));

//     final res = await _sendMessageUseCase(
//         SendMessageUseCaseParams(chat: newChat, message: [newMessage]));
//     res.fold(
//       (failure) =>
//           emit(MessageOtherAttributeMsgFailed(errorMsg: failure.message)),
//       (success) {},
//     );
//   }

//   Future<void> _textClicked(
//       TextCliked event, Emitter<MessageAttributeState> emit) async {
//     emit(MessageIsNotEmptyState());
//   }

//   @override
//   Future<void> close() {
//     _positionSubscription?.cancel();
//     _playerStateSubscription?.cancel();
//     _audioPlayers.forEach((_, player) => player.dispose());
//     _audioPlayers.clear();
//     return super.close();
//   }

//   void _setupAudioPlayer(String url) {
//     final audioPlayer = _audioPlayers[url];
//     if (audioPlayer == null) return;

//     // _positionSubscription?.cancel();
//     // _playerStateSubscription?.cancel();
//     log('listening stream');

//     _positionSubscription = audioPlayer.positionStream.listen((position) {
//       if (state is AudioState && _currentPlayingAudioUrl == url) {
//         add(SeekAudio(position, url));
//       }
//     });

//     _playerStateSubscription =
//         audioPlayer.playerStateStream.listen((playerState) {
//       if (playerState.processingState == ProcessingState.completed) {
//         add(StopAudio(url: url));
//       }
//     });
//   }

//   Future<void> _audioWantsToPlay(
//       PlayAudio event, Emitter<MessageAttributeState> emit) async {
//     if (!_audioPlayers.containsKey(event.url)) {
//       _audioPlayers[event.url] = AudioPlayer();
//     }

//     final audioPlayer = _audioPlayers[event.url]!;
//     if (_currentPlayingAudioUrl != null &&
//         _currentPlayingAudioUrl != event.url) {
//       final currentPlayer = _audioPlayers[_currentPlayingAudioUrl];
//       await currentPlayer?.stop();
//     }
//     final state = AudioState(
//         position: audioPlayer.position,
//         duration: audioPlayer.duration ?? Duration.zero,
//         url: event.url,
//         isPlaying: true);

//     log('playing in wants to play ${state.toString()}');
//     _setupAudioPlayer(event.url);

//     _currentPlayingAudioUrl = event.url;
//     await audioPlayer.setUrl(event.url);
//     await audioPlayer.play();

//     emit(state);
//   }

//   Future<void> _audioWantsToPause(
//       PauseAudio event, Emitter<MessageAttributeState> emit) async {
//     final audioPlayer = _audioPlayers[event.url];
//     if (audioPlayer == null) return;

//     await audioPlayer.pause();
//     emit(AudioState(
//         position: audioPlayer.position,
//         duration: audioPlayer.duration ?? Duration.zero,
//         url: event.url,
//         isPlaying: false));
//   }

//   Future<void> _audioSeekTo(
//       SeekAudio event, Emitter<MessageAttributeState> emit) async {
//     final audioPlayer = _audioPlayers[event.url];
//     if (audioPlayer == null) return;

//     await audioPlayer.seek(event.position);
//     emit(AudioState(
//         position: event.position,
//         duration: audioPlayer.duration ?? Duration.zero,
//         url: event.url,
//         isPlaying: true));
//   }

//   Future<void> _stopAudio(
//       StopAudio event, Emitter<MessageAttributeState> emit) async {
//     try {
//       // Cancel position and player state subscriptions
//       await _positionSubscription?.cancel();
//       await _playerStateSubscription?.cancel();
//       _positionSubscription = null;
//       _playerStateSubscription = null;

//       // Stop and dispose the current playing audio player
//       if (_currentPlayingAudioUrl != null) {
//         final currentPlayer = _audioPlayers[_currentPlayingAudioUrl];
//         if (currentPlayer != null) {
//           await currentPlayer.stop();
//           await currentPlayer.dispose();
//           _audioPlayers.remove(_currentPlayingAudioUrl);
//         }
//       }

//       // Clear current playing audio URL
//       _currentPlayingAudioUrl = null;

//       // Emit an appropriate state, here setting position and duration to zero

//       const state = AudioState(
//         position: Duration.zero,
//         duration: Duration.zero,
//         url: '',
//         isPlaying: false,
//       );

//       log('playing ${state.toString()}');
//       emit(state);
//     } catch (e) {
//       log('Error stopping audio: $e');
//       emit(const AudioState(
//         position: Duration.zero,
//         duration: Duration.zero,
//         url: '',
//         isPlaying: false,
//       ));
//     }
//   }

//   Future<void> _videoMessageClicked(
//       VideoMessageClicked event, Emitter<MessageAttributeState> emit) async {
//     final url = event.url;

//     // Retrieve or initialize the video player controller
//     final controller = await _videoCacheManager.initializeController(url);

//     // Emit the state with the video controller
//     emit(VideoPlayingState(controller: controller));
//   }
// }
