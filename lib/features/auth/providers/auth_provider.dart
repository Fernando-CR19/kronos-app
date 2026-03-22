import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kronos_app/features/auth/services/auth_service.dart';
import 'package:kronos_app/shared/services/api_provider.dart';


final authServiceProvider = Provider<AuthService>((ref) {
  final apiService = ref.watch(apiProvider);
  return AuthService(apiService);
});
