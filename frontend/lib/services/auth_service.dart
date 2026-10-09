import '../core/network/api_exception.dart';
import '../models/auth_response.dart';
import '../models/user.dart';

class AuthService {
  // true = mock, false = vrai API (Étape 10)
  static const bool useMock = true;

  Future<AuthResponse> login(String email, String password) async {
    if (useMock) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (email == 'test@example.com' && password == '123456') {
        return AuthResponse.fromJson({
          'access_token': 'mock-jwt-token',
          'token_type': 'bearer',
        });
      }
      throw ApiException('Invalid credentials', statusCode: 401);
    }
    throw UnimplementedError('API réelle: Étape 10');
  }

  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    if (useMock) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (email == 'exists@example.com') {
        throw ApiException('Email already registered', statusCode: 400);
      }
      return User.fromJson({
        'id': 1,
        'name': name,
        'email': email,
        'role': role,
      });
    }
    throw UnimplementedError('API réelle: Étape 10');
  }
}

