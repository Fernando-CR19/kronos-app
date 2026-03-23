import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kronos_app/shared/services/storage_service.dart';

final storageProvider = Provider<StorageService>((ref) {
  return StorageService();
});
