import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_color_state.dart';

class SelectColorCubit extends Cubit<SelectColorState> {
  Color _color = Colors.blue;
  Color get color => _color;
  SelectColorCubit() : super(SelectColorInitial());
  void changeColor(Color color) {
    _color = color;
    emit(SelectedColorState(color: color));
  }
}
