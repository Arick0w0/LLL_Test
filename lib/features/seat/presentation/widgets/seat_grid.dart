// lib/presentation/widgets/seat_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_booking/features/seat/data/models/seat_model.dart';
import 'package:seat_booking/features/seat/presentation/bloc/seat_bloc.dart';
import 'package:seat_booking/features/seat/presentation/bloc/seat_event.dart';

class SeatGrid extends StatelessWidget {
  final List<Seat> seats;
  final List<String> selectedSeats;
  final double height; // New parameter for height
  final double width; // New parameter for width

  const SeatGrid({
    required this.seats,
    required this.selectedSeats,
    required this.height, // Accepting height
    required this.width, // Accepting width
  });

  @override
  Widget build(BuildContext context) {
    const rows = ['A', 'B', 'C', 'D', 'E'];
    const cols = 5;

    // Map seat numbers to their corresponding row and column positions
    Map<String, Seat> seatMap = {for (var seat in seats) seat.seatNumber: seat};

    return SizedBox(
      height: height, // Fixed height
      width: width, // Fixed width
      child: Column(
        children: [
          // Row headers (1, 2, 3, 4, 5)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(cols + 1, (index) {
              if (index == 0) {
                return Container(
                  width: 30, // Width for the row labels
                );
              }
              return Expanded(
                child: Center(
                    child: Text('$index',
                        style: const TextStyle(fontWeight: FontWeight.bold))),
              );
            }),
          ),
          // Seat Grid with column labels (1, 2, 3, 4, 5)
          Expanded(
            child: GridView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols + 1, // Add extra column for row labels
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.0,
              ),
              itemCount: (rows.length * (cols + 1)), // Total grid items
              itemBuilder: (context, index) {
                final rowIndex = index ~/ (cols + 1); // Determine row
                final colIndex = index % (cols + 1); // Determine column

                // Display row label (A, B, C, etc.)
                if (colIndex == 0) {
                  return Center(
                      child: Text(rows[rowIndex],
                          style: const TextStyle(fontWeight: FontWeight.bold)));
                }

                // Calculate seat number for current grid position
                String seatNumber = '${rows[rowIndex]}$colIndex';
                Seat? seat = seatMap[seatNumber];

                if (seat != null) {
                  return GestureDetector(
                    onTap: () {
                      // Handle seat selection and deselection
                      if (selectedSeats.contains(seat.seatNumber)) {
                        // If the seat is already selected, unselect it
                        BlocProvider.of<SeatBloc>(context)
                            .add(CancelSeatEvent(seat.seatNumber));
                      } else {
                        // Otherwise, select the seat
                        BlocProvider.of<SeatBloc>(context)
                            .add(SelectSeatEvent(seat.seatNumber));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedSeats.contains(seat.seatNumber)
                            ? Colors.lightGreen // Selected seat color
                            : (seat.status == 'available'
                                ? Colors.grey // Available seat color
                                : Colors.red), // Not available seat color
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      // No text inside the seat boxes
                    ),
                  );
                } else {
                  // In case there is no seat at this position (optional)
                  return Container(color: Colors.transparent);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
