import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
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

  Future<void> forgotPassword({required String email}) async {
    await _apiService.client.post(
      '/auth/forgot-password',
      data: {'email': email}
    );
  }

  Future<void> validateOtp({
    required String email,
    required String code
  }) async {
    await _apiService.client.post(
      '/auth/validate-otp',
      data: {
        'email': email,
        'code': code
      }
    );
  }

  Future<void> resetPassword({
    required String email,
    required String password,
  }) async {
    await _apiService.client.post(
      '/auth/reset-password',
      data: {
        'email': email,
        'password': password,
      }
    );
  }

  Future<Map<String, dynamic>> googleSignIn() async {
    final authUrl = '${dotenv.env['BASE_URL']}/auth/google';
    final callbackSchema = 'kronos';

    final result = await FlutterWebAuth2.authenticate(
      url: authUrl,
      callbackUrlScheme: callbackSchema
    );

    final uri = Uri.parse(result);
    final token = uri.queryParameters['token'];
    final accountExists = uri.queryParameters['account_exists'];
    final firstLogin = uri.queryParameters['first_login'];
    final email = uri.queryParameters['email'];
    final googleId = uri.queryParameters['google_id'];

    return {
      'token': token,
      'account_exists': accountExists,
      'first_login': firstLogin,
      'email': email,
      'google_id': googleId,
    };
  }

  Future<Map<String, dynamic>> linkGoogleAccount({
    required String email,
    required String googleId,
  }) async {
    final response = await _apiService.client.post(
      '/auth/google-link',
      data: {
        'email': email,
        'googleId': googleId,
      }
    );
    
    return response.data;
  }
}
