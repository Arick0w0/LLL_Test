// lib/presentation/blocs/seat_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_seats.dart';
import 'seat_event.dart';
import 'seat_state.dart';

class SeatBloc extends Bloc<SeatEvent, SeatState> {
  final GetSeats getSeats;

  SeatBloc(this.getSeats) : super(SeatsLoading()) {
    on<FetchSeatsEvent>((event, emit) async {
      emit(SeatsLoading());
      try {
        final seatModel = await getSeats();
        emit(SeatsLoaded(seatModel));
      } catch (e) {
        emit(SeatsError("Failed to fetch seats"));
      }
    });

    on<SelectSeatEvent>((event, emit) {
      if (state is SeatsLoaded) {
        final currentState = state as SeatsLoaded;
        final updatedSelectedSeats =
            List<String>.from(currentState.selectedSeats);

        if (!updatedSelectedSeats.contains(event.seatNumber)) {
          updatedSelectedSeats.add(event.seatNumber);
        }

        emit(SeatsLoaded(currentState.seatModel,
            selectedSeats: updatedSelectedSeats));
      }
    });

    on<CancelSeatEvent>((event, emit) {
      if (state is SeatsLoaded) {
        final currentState = state as SeatsLoaded;
        final updatedSelectedSeats =
            List<String>.from(currentState.selectedSeats);

        if (updatedSelectedSeats.contains(event.seatNumber)) {
          updatedSelectedSeats.remove(event.seatNumber);
        }

        emit(SeatsLoaded(currentState.seatModel,
            selectedSeats: updatedSelectedSeats));
      }
    });
  }
}
