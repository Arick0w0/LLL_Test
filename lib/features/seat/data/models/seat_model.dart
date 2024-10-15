// lib/data/models/seat_model.dart
class SeatModel {
  final Venue venue;
  final SeatLayout seatLayout;

  SeatModel({required this.venue, required this.seatLayout});

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      venue: Venue.fromJson(json['venue']),
      seatLayout: SeatLayout.fromJson(json['seatLayout']),
    );
  }
}

class Venue {
  final String name;
  final int capacity;

  Venue({required this.name, required this.capacity});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      name: json['name'],
      capacity: json['capacity'],
    );
  }
}

class SeatLayout {
  final int rows;
  final int columns;
  final List<Seat> seats;

  SeatLayout({required this.rows, required this.columns, required this.seats});

  factory SeatLayout.fromJson(Map<String, dynamic> json) {
    var seatsList =
        (json['seats'] as List).map((i) => Seat.fromJson(i)).toList();
    return SeatLayout(
      rows: json['rows'],
      columns: json['columns'],
      seats: seatsList,
    );
  }
}

class Seat {
  final String seatNumber;
  final String status;

  Seat({required this.seatNumber, required this.status});

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatNumber: json['seatNumber'],
      status: json['status'],
    );
  }
}
