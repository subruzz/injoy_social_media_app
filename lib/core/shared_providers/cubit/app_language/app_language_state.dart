

part of 'app_language_cubit.dart';

class AppLanguageState extends Equatable {
  final Locale locale;

  const AppLanguageState(this.locale);

  AppLanguageState copyWith({Locale? locale}) {
    return AppLanguageState(
      locale ?? this.locale,
    );
  }

  @override
  List<Object> get props => [locale];
}
