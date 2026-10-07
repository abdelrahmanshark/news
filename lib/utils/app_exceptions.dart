/// Thrown when the news API answers with an error status.
class ApiException implements Exception {
  const ApiException(this.message);

  final String? message;
}

/// Thrown when the device is offline and nothing was cached yet.
class NoCachedDataException implements Exception {
  const NoCachedDataException();
}

/// Thrown when a request that has no offline fallback (like the next page) runs offline.
class OfflineException implements Exception {
  const OfflineException();
}
