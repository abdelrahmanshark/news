import 'package:http/http.dart' as http;
import 'package:news/generated/l10n.dart';
import 'package:news/utils/app_exceptions.dart';

class NetworkUtils {
  /// Turns any error into a short message the user can understand.
  static String failureMessageFor(Object error) {
    if (error is ApiException) {
      return error.message ?? S.current.somethingWentWrong;
    }
    if (error is NoCachedDataException) {
      return S.current.offlineNoCache;
    }
    if (error is OfflineException || error is http.ClientException) {
      return S.current.checkConnection;
    }
    return S.current.somethingWentWrong;
  }
}
