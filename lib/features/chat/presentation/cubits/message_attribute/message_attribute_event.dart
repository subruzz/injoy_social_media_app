part of 'message_attribute_bloc.dart';

sealed class MessageAttributeEvent extends Equatable {
  const MessageAttributeEvent();

  @override
  List<Object> get props => [];
}

final class AudioMessageClicked extends MessageAttributeEvent {}

final class AudioMessageOnGoing extends MessageAttributeEvent {}

final class AudioMessageStopped extends MessageAttributeEvent {}

final class TextCliked extends MessageAttributeEvent {}

final class PlayAudio extends MessageAttributeEvent {
  final String url;
  const PlayAudio({required this.url});
}

class PauseAudio extends MessageAttributeEvent {
  final String url;

  const PauseAudio({required this.url});
}

class StopAudio extends MessageAttributeEvent {
  final String url;
  const StopAudio({required this.url});
}

class SeekAudio extends MessageAttributeEvent {
  final Duration position;
  final String url;

  const SeekAudio(this.position, this.url);

  @override
  List<Object> get props => [position];
}

class VideoMessageClicked extends MessageAttributeEvent {
  final String url;

  const VideoMessageClicked({required this.url});
}
