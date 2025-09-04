import 'package:travelmakerapp/entities/validator.dart';

abstract class TravelRepository {
  Future<int> insertTravel(Map<String, dynamic> travel);
  Future<int> updateTravel(int id, Map<String, dynamic> travel);
  Future<int> deleteTravel(int id);
}