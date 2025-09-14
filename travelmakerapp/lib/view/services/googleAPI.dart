import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelmakerapp/view/services/get_api_key.dart';

// need a string that goes to image.network

Future<List<Map<String, dynamic>>> fetchCitySuggestions(String input) async {
  if (input.trim().isEmpty) return [];

  final encoded = Uri.encodeComponent(input);
  final url =
      'https://nominatim.openstreetmap.org/search?q=$encoded&format=json&addressdetails=1&limit=8&accept-language=pt-BR';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'User-Agent': 'TravelMakerApp (rafinha84.dev@gmail.com)',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch cities. Status code: ${response.statusCode}');
  }

  final List data = jsonDecode(response.body) as List;
  final List<Map<String, dynamic>> results = [];

  for (final item in data) {
    final address = (item['address'] ?? {}) as Map<String, dynamic>;

    // Keep only settlements (cities, towns, villages, etc.)
    final type = item['type']?.toString() ?? '';
    final validTypes = ['city', 'town', 'village', 'hamlet', 'municipality'];

    if (!validTypes.contains(type)) {
      continue; // skip states, counties, etc.
    }

    final city = (address['city'] ??
        address['town'] ??
        address['village'] ??
        address['municipality'] ??
        address['hamlet'] ??
        '')
        .toString()
        .trim();

    final country = (address['country'] ?? '').toString().trim();

    final description = [city, country].where((s) => s.isNotEmpty).join(', ');

    if (description.isEmpty) continue;

    final lat = double.tryParse(item['lat']?.toString() ?? '');
    final lng = double.tryParse(item['lon']?.toString() ?? '');

    results.add({
      'description': description,
      'lat': lat,
      'lng': lng,
      'raw': item,
    });
  }

  return results;
}

Future<Map<String, double>> fetchCoordinatesFromPlaceId(String placeId) async {
  final url =
      'https://nominatim.openstreetmap.org/lookup?osm_ids=N$placeId&format=json';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'User-Agent': 'TravelMakerApp (rafinha84.dev@gmail.com)',
    },
  );

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);

    if (data.isNotEmpty) {
      return {
        'lat': double.tryParse(data[0]['lat']) ?? 0.0,
        'lng': double.tryParse(data[0]['lon']) ?? 0.0,
      };
    } else {
      throw Exception('Local não encontrado no Nominatim.');
    }
  } else {
    throw Exception(
        'Falha ao buscar coordenadas. Status code: ${response.statusCode}');
  }
}



