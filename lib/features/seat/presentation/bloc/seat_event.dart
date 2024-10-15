// lib/presentation/blocs/seat_event.dart
abstract class SeatEvent {}

class FetchSeatsEvent extends SeatEvent {}

class SelectSeatEvent extends SeatEvent {
  final String seatNumber;

  SelectSeatEvent(this.seatNumber);
}

class CancelSeatEvent extends SeatEvent {
  final String seatNumber;

  CancelSeatEvent(this.seatNumber);
}
