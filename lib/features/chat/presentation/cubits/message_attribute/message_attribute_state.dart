// part of 'message_attribute_bloc.dart';

// sealed class MessageAttributeState extends Equatable {
//   const MessageAttributeState();

//   @override
//   List<Object> get props => [];
// }

// final class MessageAttributeInitial extends MessageAttributeState {}

// final class AudioOngoingState extends MessageAttributeState {
//   final int duration;
//   @override
//   List<Object> get props => [duration];
//   const AudioOngoingState({required this.duration});
// }

// final class AudioStoppedState extends MessageAttributeState {
//   final int duration;
//   @override
//   List<Object> get props => [duration];
//   const AudioStoppedState({required this.duration});
// }

// final class AudioStartedState extends MessageAttributeState {}

// final class MessageIsNotEmptyState extends MessageAttributeState {}

// final class MessageOtherAttributeMsgFailed extends MessageAttributeState {
//   final String errorMsg;

//   const MessageOtherAttributeMsgFailed({required this.errorMsg});
// }

// class AudioState extends MessageAttributeState {
//   final Duration position;
//   final Duration duration;
//   final String url;
//   final bool isPlaying;

//   const AudioState({
//     required this.position,
//     required this.duration,
//     required this.url,
//     required this.isPlaying,
//   });

//   @override
//   List<Object> get props => [position, duration, url, isPlaying];

//   AudioState copyWith({
//     Duration? position,
//     Duration? duration,
//     String? url,
//     bool? isPlaying,
//   }) {
//     return AudioState(
//       position: position ?? this.position,
//       duration: duration ?? this.duration,
//       url: url ?? this.url,
//       isPlaying: isPlaying ?? this.isPlaying,
//     );
//   }

//   @override
//   String toString() {
//     return 'AudioState(position: $position, duration: $duration, url: $url, isPlaying: $isPlaying)';
//   }
// }

// final class VideoPlayingState extends MessageAttributeState {
//   final VideoPlayerController controller;

//   const VideoPlayingState({required this.controller});
// }
