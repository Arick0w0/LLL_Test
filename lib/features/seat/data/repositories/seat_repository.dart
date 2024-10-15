// lib/data/repositories/seat_repository.dart
import 'package:seat_booking/features/seat/data/datasources/seat_api.dart';

import '../models/seat_model.dart';

class SeatRepository {
  final SeatApi seatApi;

  SeatRepository(this.seatApi);

  Future<SeatModel> getSeats() async {
    return await seatApi.fetchSeats();
  }
}
