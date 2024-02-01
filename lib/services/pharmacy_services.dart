// pharmacy_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pharmacy_model.dart';

class PharmacyService {
  static const String apiKey = "6TDCo259AOYtCe6SBL7eZu:73w4JdLvlY3lkkUVMcuTbF";
  static const String baseUrl = "https://api.collectapi.com/health";

  Future<List<Pharmacy>> getDutyPharmacies(String state, String county) async {
    List<Pharmacy> pharmacies = [];

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/dutyPharmacy?ilce=$state&il=$county'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'apikey $apiKey',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true) {
          pharmacies = List<Pharmacy>.from(data['result'].map((pharmacyData) => Pharmacy.fromJson(pharmacyData)));
        } else {
          print("API request failed: ${data['message']}");
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }

    return pharmacies;
  }
}

