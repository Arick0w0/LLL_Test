// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_booking/features/seat/data/datasources/seat_api.dart';
import 'package:seat_booking/features/seat/data/repositories/seat_repository.dart';
import 'package:seat_booking/features/seat/domain/usecases/get_seats.dart';
import 'package:seat_booking/features/seat/presentation/bloc/seat_bloc.dart';
import 'package:seat_booking/features/seat/presentation/bloc/seat_event.dart';
import 'package:seat_booking/features/seat/presentation/pages/seat_booking_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seat Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => SeatBloc(GetSeats(SeatRepository(SeatApi())))
          ..add(FetchSeatsEvent()),
        child: SeatBookingPage(),
      ),
    );
  }
}
