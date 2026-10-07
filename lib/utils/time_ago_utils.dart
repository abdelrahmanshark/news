import 'package:intl/intl.dart';
import 'package:news/generated/l10n.dart';

class TimeAgoUtils {
  /// Turns [dateTime] into relative text like "5 minutes ago",
  /// falling back to a short date once it is a week old.
  static String format(DateTime dateTime) {
    final Duration elapsed = DateTime.now().difference(dateTime);
    if (elapsed.inMinutes < 1) return S.current.justNow;
    if (elapsed.inHours < 1) return S.current.minutesAgo(elapsed.inMinutes);
    if (elapsed.inDays < 1) return S.current.hoursAgo(elapsed.inHours);
    if (elapsed.inDays < 7) return S.current.daysAgo(elapsed.inDays);
    return DateFormat.yMMMd(Intl.getCurrentLocale()).format(dateTime.toLocal());
  }
}
