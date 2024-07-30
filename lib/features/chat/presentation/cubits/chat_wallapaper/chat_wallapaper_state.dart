part of 'chat_wallapaper_cubit.dart';

sealed class ChatWallapaperState extends Equatable {
  const ChatWallapaperState();

  @override
  List<Object> get props => [];
}

final class ChatWallapaperInitial extends ChatWallapaperState {}

final class ChatWallapaperLoading extends ChatWallapaperState {}

final class ChatWallapaperError extends ChatWallapaperState {}

final class ChatWallapaperStored extends ChatWallapaperState {}

final class ChatWallapaperSuccess extends ChatWallapaperState {
  final String wallapaperPath;

  const ChatWallapaperSuccess({required this.wallapaperPath});
}
