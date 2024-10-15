// lib/data/data_sources/seat_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/seat_model.dart';

class SeatApi {
  Future<SeatModel> fetchSeats() async {
    final response = await http
        .get(Uri.parse('https://thexkpx.github.io/json/seating.json'));

    if (response.statusCode == 200) {
      return SeatModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load seats');
    }
  }
}
