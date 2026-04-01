class AuthRepository {
  Future<bool> register({required String email, required String password}) async {
    // simulate network
    await Future.delayed(const Duration(seconds: 2));
    return true; // successful registration
  }
}
