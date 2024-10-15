// lib/presentation/pages/seat_booking_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_booking/features/seat/data/datasources/seat_api.dart';
import 'package:seat_booking/features/seat/data/models/seat_model.dart';
import 'package:seat_booking/features/seat/data/repositories/seat_repository.dart';
import 'package:seat_booking/features/seat/domain/usecases/get_seats.dart';
import 'package:seat_booking/features/seat/presentation/bloc/seat_bloc.dart';
import 'package:seat_booking/features/seat/presentation/bloc/seat_event.dart';
import 'package:seat_booking/features/seat/presentation/bloc/seat_state.dart';
import 'package:seat_booking/features/seat/presentation/widgets/seat_grid.dart';
import 'package:seat_booking/features/seat/presentation/widgets/selected_seats_display.dart';

class SeatBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ເລືອກບ່ອນນັ່ງ')),
      body: BlocProvider(
        create: (context) => SeatBloc(GetSeats(SeatRepository(SeatApi())))
          ..add(FetchSeatsEvent()),
        child: BlocBuilder<SeatBloc, SeatState>(
          builder: (context, state) {
            if (state is SeatsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SeatsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: 10),
                    SeatGrid(
                      seats: state.seatModel.seatLayout.seats,
                      selectedSeats: state.selectedSeats,
                      height: 300, // Customize the height
                      width: 200, // Customize the width
                    ),
                    const SizedBox(height: 100),
                    const Divider(),
                    SelectedSeatsDisplay(
                      selectedSeats: state.selectedSeats,
                    ),
                  ],
                ),
              );
            } else if (state is SeatsError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
