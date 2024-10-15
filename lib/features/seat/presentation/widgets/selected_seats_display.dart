// lib/presentation/widgets/selected_seats_display.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_booking/features/seat/presentation/bloc/seat_bloc.dart';
import 'package:seat_booking/features/seat/presentation/bloc/seat_event.dart';

class SelectedSeatsDisplay extends StatelessWidget {
  final List<String> selectedSeats;

  const SelectedSeatsDisplay({required this.selectedSeats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ບ່ອນນັ່ງ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        Wrap(
          spacing: 4.0,
          children: selectedSeats.map((seatNumber) {
            return Chip(
              backgroundColor: Colors.black,
              label: Text(
                seatNumber,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              deleteIcon:
                  const Icon(Icons.cancel_outlined, color: Colors.white),
              onDeleted: () {
                // Cancel seat selection
                BlocProvider.of<SeatBloc>(context)
                    .add(CancelSeatEvent(seatNumber));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
