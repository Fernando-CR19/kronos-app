import '../../../shared/services/api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<void> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    await _apiService.client.post(
      '/auth/register-user',
      data: {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      },
    );
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password
  }) async {
    final response = await _apiService.client.post(
      '/auth/login-user',
      data: {
        'email': email,
        'password': password
      },
    );

    return response.data;
  }
}
