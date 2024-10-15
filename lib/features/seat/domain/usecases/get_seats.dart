// lib/domain/usecases/get_seats.dart
import 'package:seat_booking/features/seat/data/models/seat_model.dart';

import '../../data/repositories/seat_repository.dart';

class GetSeats {
  final SeatRepository repository;

  GetSeats(this.repository);

  Future<SeatModel> call() async {
    return await repository.getSeats();
  }
}
