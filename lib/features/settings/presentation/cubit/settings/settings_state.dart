part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class NotifiationPreferenceLoading extends SettingsState {}

final class NotifiationPreferenceError extends SettingsState {
  final String errorMsg;

  const NotifiationPreferenceError({
    required this.errorMsg,
  });
}

final class NotifiationPreferenceSuccess extends SettingsState {}

final class ChangePasswordLoading extends SettingsState {}

final class ChangePasswordError extends SettingsState {
  final String error;

  const ChangePasswordError({required this.error});
}

final class ChangeEmailSuccess extends SettingsState {}

final class ClearChatLoading extends SettingsState {}

final class ClearChatSuccess extends SettingsState {}

final class ClearChatFailed extends SettingsState {}
