import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news/di/injection.config.dart';

final GetIt getIt = GetIt.instance;

bool _isConfigured = false;

/// Registers every injectable dependency; safe to call more than once.
@InjectableInit(preferRelativeImports: false)
void configureDependencies() {
  if (_isConfigured) return;
  getIt.init();
  _isConfigured = true;
}
