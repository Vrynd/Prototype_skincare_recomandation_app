import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  bool get isAuthenticated => client.auth.currentSession != null;
  User? get currentUser => client.auth.currentUser;

  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
