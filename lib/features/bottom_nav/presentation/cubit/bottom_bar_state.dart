part of 'bottom_bar_cubit.dart';

class BottomBarState extends Equatable {
  const BottomBarState({
    required this.index,
    this.canPopFromTheExplore = true,
  });

  final int index;
  final bool canPopFromTheExplore;

  // Adding a copyWith method
  BottomBarState copyWith({
    int? index,
    bool? canPopFromTheExplore,
  }) {
    return BottomBarState(
      index: index ?? this.index,
      canPopFromTheExplore: canPopFromTheExplore ?? this.canPopFromTheExplore,
    );
  }

  @override
  List<Object> get props => [index, canPopFromTheExplore];
}
