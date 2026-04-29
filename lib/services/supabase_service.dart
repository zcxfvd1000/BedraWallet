import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

const String supabaseUrl = 'https://dummy.supabase.co';
const String supabaseAnonKey = 'dummykey.updateyourkkey.here';

class SupabaseService {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authFlowType: AuthFlowType.pkce,
    );
  }

  static Future<bool> loginWithPhoneAndPassword(
      String phone, String password) async {
    final response = await Supabase.instance.client.functions.invoke(
      'login_with_phone',
      body: {
        'phone': phone.trim(),
        'password': password.trim(),
      },
    );

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    final data = response.data;
    if (data is String && data.isNotEmpty) {
      final decoded = jsonDecode(data);
      return decoded['authenticated'] == true;
    }

    if (data is Map<String, dynamic>) {
      return data['authenticated'] == true;
    }

    return false;
  }

  static Future<Map<String, dynamic>> verifyTransactionPin(
      String phone, String pin) async {
    final response = await Supabase.instance.client.functions.invoke(
      'verify_security_pin',
      body: {
        'phone': phone.trim(),
        'pin': pin.trim(),
      },
    );

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    final data = response.data;
    if (data is String && data.isNotEmpty) {
      return Map<String, dynamic>.from(jsonDecode(data));
    }

    if (data is Map<String, dynamic>) {
      return data;
    }

    return {};
  }
}
