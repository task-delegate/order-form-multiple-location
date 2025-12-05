import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleSheetsService {
  static final String _gasUrl = dotenv.env['GAS_URL'] ?? '';

  // Submit order to Google Sheet
  static Future<bool> submitOrderToSheet(Map<String, dynamic> orderData) async {
    try {
      final response = await http
          .post(
            Uri.parse(_gasUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'action': 'submitOrder', 'data': orderData}),
          )
          .timeout(const Duration(seconds: 30));

      return response.statusCode == 200;
    } catch (e) {
      print('Error submitting to Google Sheets: $e');
      return false;
    }
  }

  // Fetch master data from Google Sheet
  static Future<List<Map<String, dynamic>>> fetchMasterData(
    String dataType,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse(_gasUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'action': 'getMasterData', 'type': dataType}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['data'] ?? []);
      }
      return [];
    } catch (e) {
      print('Error fetching master data: $e');
      return [];
    }
  }
}
