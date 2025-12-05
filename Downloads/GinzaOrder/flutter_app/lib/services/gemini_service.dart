import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static late GenerativeModel _model;

  static void initialize() {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  }

  // Parse order from text using Gemini
  static Future<Map<String, dynamic>> parseOrderFromText(String text) async {
    try {
      final prompt =
          '''
      Parse the following order information and extract:
      - customer_name
      - contact_no
      - email
      - items (list with: name, quantity, rate)
      - delivery_date
      - remarks
      
      Text: $text
      
      Return as JSON format.
      ''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      // Parse response - simplified version
      return {'success': true, 'data': response.text};
    } catch (e) {
      print('Error parsing order: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  // Generate order summary
  static Future<String> generateOrderSummary(
    String customerName,
    List<Map<String, dynamic>> items,
    double total,
  ) async {
    try {
      final itemsList = items
          .map(
            (item) =>
                '${item['name']} - Qty: ${item['qty']} x Rate: ${item['rate']}',
          )
          .join('\n');

      final prompt =
          '''
      Generate a professional order summary for:
      Customer: $customerName
      Items:
      $itemsList
      
      Total Amount: ₹$total
      
      Keep it concise and professional.
      ''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      return response.text ?? '';
    } catch (e) {
      print('Error generating summary: $e');
      return '';
    }
  }
}
