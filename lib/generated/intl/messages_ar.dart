// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(author) => "بواسطة ${author}";

  static String m1(code) =>
      "${Intl.select(code, {'ae': 'الإمارات العربية المتحدة', 'ar': 'الأرجنتين', 'at': 'النمسا', 'au': 'أستراليا', 'be': 'بلجيكا', 'bg': 'بلغاريا', 'br': 'البرازيل', 'ca': 'كندا', 'ch': 'سويسرا', 'cn': 'الصين', 'co': 'كولومبيا', 'cu': 'كوبا', 'cz': 'التشيك', 'de': 'ألمانيا', 'eg': 'مصر', 'fr': 'فرنسا', 'gb': 'المملكة المتحدة', 'gr': 'اليونان', 'hk': 'هونغ كونغ', 'hu': 'المجر', 'id': 'إندونيسيا', 'ie': 'أيرلندا', 'il': 'إسرائيل', 'in': 'الهند', 'it': 'إيطاليا', 'jp': 'اليابان', 'kr': 'كوريا الجنوبية', 'lt': 'ليتوانيا', 'lv': 'لاتفيا', 'ma': 'المغرب', 'mx': 'المكسيك', 'my': 'ماليزيا', 'ng': 'نيجيريا', 'nl': 'هولندا', 'no': 'النرويج', 'nz': 'نيوزيلندا', 'ph': 'الفلبين', 'pl': 'بولندا', 'pt': 'البرتغال', 'ro': 'رومانيا', 'rs': 'صربيا', 'ru': 'روسيا', 'sa': 'السعودية', 'se': 'السويد', 'sg': 'سنغافورة', 'si': 'سلوفينيا', 'sk': 'سلوفاكيا', 'th': 'تايلاند', 'tr': 'تركيا', 'tw': 'تايوان', 'ua': 'أوكرانيا', 'us': 'الولايات المتحدة', 've': 'فنزويلا', 'za': 'جنوب أفريقيا', 'other': 'أخرى'})}";

  static String m2(count) =>
      "${Intl.plural(count, one: 'منذ يوم', two: 'منذ يومين', few: 'منذ ${count} أيام', other: 'منذ ${count} يومًا')}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'منذ ساعة', two: 'منذ ساعتين', few: 'منذ ${count} ساعات', other: 'منذ ${count} ساعة')}";

  static String m4(count) =>
      "${Intl.plural(count, one: 'منذ دقيقة', two: 'منذ دقيقتين', few: 'منذ ${count} دقائق', other: 'منذ ${count} دقيقة')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addToFavorites": MessageLookupByLibrary.simpleMessage("إضافة إلى المفضلة"),
    "allCountries": MessageLookupByLibrary.simpleMessage("كل الدول"),
    "appName": MessageLookupByLibrary.simpleMessage("تطبيق الأخبار"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "byAuthor": m0,
    "categoryBreaking": MessageLookupByLibrary.simpleMessage("عاجل"),
    "categoryBusiness": MessageLookupByLibrary.simpleMessage("أعمال"),
    "categoryCrime": MessageLookupByLibrary.simpleMessage("جريمة"),
    "categoryDomestic": MessageLookupByLibrary.simpleMessage("محلي"),
    "categoryEducation": MessageLookupByLibrary.simpleMessage("تعليم"),
    "categoryEntertainment": MessageLookupByLibrary.simpleMessage("ترفيه"),
    "categoryEnvironment": MessageLookupByLibrary.simpleMessage("بيئة"),
    "categoryFood": MessageLookupByLibrary.simpleMessage("طعام"),
    "categoryHealth": MessageLookupByLibrary.simpleMessage("صحة"),
    "categoryLifestyle": MessageLookupByLibrary.simpleMessage("أسلوب الحياة"),
    "categoryOther": MessageLookupByLibrary.simpleMessage("أخرى"),
    "categoryPolitics": MessageLookupByLibrary.simpleMessage("سياسة"),
    "categoryScience": MessageLookupByLibrary.simpleMessage("علوم"),
    "categorySports": MessageLookupByLibrary.simpleMessage("رياضة"),
    "categoryTechnology": MessageLookupByLibrary.simpleMessage("تكنولوجيا"),
    "categoryTop": MessageLookupByLibrary.simpleMessage("أهم الأخبار"),
    "categoryTourism": MessageLookupByLibrary.simpleMessage("سياحة"),
    "categoryWorld": MessageLookupByLibrary.simpleMessage("العالم"),
    "checkConnection": MessageLookupByLibrary.simpleMessage(
      "يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.",
    ),
    "country": MessageLookupByLibrary.simpleMessage("الدولة"),
    "countryName": m1,
    "dark": MessageLookupByLibrary.simpleMessage("داكن"),
    "daysAgo": m2,
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "filterAll": MessageLookupByLibrary.simpleMessage("الكل"),
    "filterFavorites": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "goToHome": MessageLookupByLibrary.simpleMessage("الذهاب للرئيسية"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "hoursAgo": m3,
    "justNow": MessageLookupByLibrary.simpleMessage("الآن"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "light": MessageLookupByLibrary.simpleMessage("فاتح"),
    "minutesAgo": m4,
    "noArticles": MessageLookupByLibrary.simpleMessage(
      "لا توجد مقالات منشورة بعد",
    ),
    "noCategoriesFound": MessageLookupByLibrary.simpleMessage(
      "لا توجد فئات مطابقة",
    ),
    "noCountriesFound": MessageLookupByLibrary.simpleMessage(
      "لا توجد دول مطابقة",
    ),
    "noFavoriteCategories": MessageLookupByLibrary.simpleMessage(
      "لا توجد فئات مفضلة بعد",
    ),
    "offlineNoCache": MessageLookupByLibrary.simpleMessage(
      "أنت غير متصل بالإنترنت ولا توجد بيانات محفوظة بعد.",
    ),
    "openTheLink": MessageLookupByLibrary.simpleMessage("فتح الرابط"),
    "removeFromFavorites": MessageLookupByLibrary.simpleMessage(
      "إزالة من المفضلة",
    ),
    "searchCategories": MessageLookupByLibrary.simpleMessage("ابحث في الفئات"),
    "searchCountry": MessageLookupByLibrary.simpleMessage("ابحث عن دولة"),
    "searchNews": MessageLookupByLibrary.simpleMessage("ابحث في الأخبار"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ ما. يرجى المحاولة مرة أخرى.",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("المظهر"),
    "viewAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
  };
}
