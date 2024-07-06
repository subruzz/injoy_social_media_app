import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'interest_select_event.dart';
part 'interest_select_state.dart';

class InterestSelectBloc extends Bloc<InterestSelectEvent, InterestSelectState> {
  InterestSelectBloc() : super(InterestSelectInitial()) {
    on<InterestSelectEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
