import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static late SupabaseClient _client;

  static Future<void> initialize() async {
    final url = dotenv.env['SUPABASE_URL'] ?? '';
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

    await Supabase.initialize(url: url, anonKey: anonKey);
    _client = Supabase.instance.client;
  }

  static SupabaseClient get client => _client;

  // Fetch customers by sales person
  static Future<List<Map<String, dynamic>>> fetchCustomers(
    String branchId,
    String salesPersonId,
  ) async {
    try {
      final response = await _client
          .from('customers')
          .select()
          .eq('branch', branchId)
          .eq('sales_person_id', salesPersonId);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching customers: $e');
      return [];
    }
  }

  // Fetch master items
  static Future<List<Map<String, dynamic>>> fetchMasterItems() async {
    try {
      final response = await _client.from('master_items').select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }

  // Save order to database
  static Future<bool> saveOrder(Map<String, dynamic> orderData) async {
    try {
      await _client.from('orders').insert(orderData);
      return true;
    } catch (e) {
      print('Error saving order: $e');
      return false;
    }
  }

  // Login user
  static Future<bool> loginUser(String email, String password) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      return true;
    } catch (e) {
      print('Error logging in: $e');
      return false;
    }
  }

  // Register user
  static Future<bool> registerUser(String email, String password) async {
    try {
      await _client.auth.signUp(email: email, password: password);
      return true;
    } catch (e) {
      print('Error registering: $e');
      return false;
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  // Logout
  static Future<void> logout() async {
    await _client.auth.signOut();
  }
}
