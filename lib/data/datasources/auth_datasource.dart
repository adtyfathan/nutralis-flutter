import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthDataSource {
  final SupabaseClient supabase;

  AuthDataSource(this.supabase);

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Failed to create user');
      }

      final user = UserModel(
        uid: response.user!.id,
        username: username,
        email: email,
        avatar: 'avatar1',
        createdAt: DateTime.now(),
      );

      await supabase.from('users').insert(user.toJson());

      return user;
    } catch (e) {
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Failed to sign in');
      }

      return await getUserData(response.user!.id);
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<UserModel> getUserData(String uid) async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('uid', uid)
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get user data: ${e.toString()}');
    }
  }

  Future<UserModel> updateUserData({
    required String uid,
    required String username,
    required String avatar,
  }) async {
    try {
      await supabase
          .from('users')
          .update({'username': username, 'avatar': avatar})
          .eq('uid', uid);

      return await getUserData(uid);
    } catch (e) {
      throw Exception('Failed to update user: ${e.toString()}');
    }
  }

  Future<void> deleteAccount(String uid) async {
    try {
      await supabase.from('users').delete().eq('uid', uid);
      // Note: Supabase admin API is needed to delete auth user
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception('Failed to delete account: ${e.toString()}');
    }
  }

  User? get currentUser => supabase.auth.currentUser;

  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;
}
