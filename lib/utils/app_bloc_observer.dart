import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  /// Logs every new cubit/bloc.
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- ${bloc.runtimeType}');
  }

  /// Logs every state change.
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- ${bloc.runtimeType}, $change');
  }

  /// Logs every uncaught cubit/bloc error.
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  /// Logs every closed cubit/bloc.
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}');
  }
}
