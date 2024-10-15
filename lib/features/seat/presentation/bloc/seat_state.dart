// lib/presentation/blocs/seat_state.dart
import '../../data/models/seat_model.dart';

abstract class SeatState {}

class SeatsLoading extends SeatState {}

class SeatsLoaded extends SeatState {
  final SeatModel seatModel;
  final List<String> selectedSeats; // Add selected seats

  SeatsLoaded(this.seatModel, {this.selectedSeats = const []});
}

class SeatsError extends SeatState {
  final String message;

  SeatsError(this.message);
}
