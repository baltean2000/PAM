import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../domain/models.dart';

class BarbershopRepository {
  Future<Map<String, dynamic>> _loadJsonData() async {
    String data = await rootBundle.loadString('assets/v2.json');
    return json.decode(data);
  }

  Future<List<Barbershop>> getNearestBarbershops() async {
    final jsonData = await _loadJsonData();
    List<dynamic> nearestBarbershops = jsonData['nearest_barbershop'] ?? [];
    return nearestBarbershops.map((shop) => Barbershop.fromJson(shop)).toList();
  }

  Future<List<Barbershop>> getMostRecommendedBarbershops() async {
    final jsonData = await _loadJsonData();
    List<dynamic> mostRecommended = jsonData['most_recommended'] ?? [];
    return mostRecommended.map((shop) => Barbershop.fromJson(shop)).toList();
  }

  Future<List<Barbershop>> getPopularChoices() async {
    final jsonData = await _loadJsonData();
    List<dynamic> popularChoices = jsonData['list'] ?? [];
    return popularChoices.map((shop) => Barbershop.fromJson(shop)).toList();
  }

  Future<AdBanner> getBanner() async {
    final jsonData = await _loadJsonData();
    return AdBanner.fromJson(jsonData['banner']);
  }
}
