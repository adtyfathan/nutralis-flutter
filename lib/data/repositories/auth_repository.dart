import '../datasources/auth_datasource.dart';
import '../models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final AuthDataSource dataSource;

  AuthRepository(this.dataSource);

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    return await dataSource.signUp(
      email: email,
      password: password,
      username: username,
    );
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    return await dataSource.signIn(email: email, password: password);
  }

  Future<void> signOut() async {
    await dataSource.signOut();
  }

  Future<UserModel> getUserData(String uid) async {
    return await dataSource.getUserData(uid);
  }

  Future<UserModel> updateUserData({
    required String uid,
    required String username,
    required String avatar,
  }) async {
    return await dataSource.updateUserData(
      uid: uid,
      username: username,
      avatar: avatar,
    );
  }

  Future<void> deleteAccount(String uid) async {
    await dataSource.deleteAccount(uid);
  }

  User? get currentUser => dataSource.currentUser;

  Stream<AuthState> get authStateChanges => dataSource.authStateChanges;
}
