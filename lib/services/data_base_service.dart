import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news/utils/hive_boxes.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class DataBaseService {
  /// Initializes Hive and opens the box used for offline caching.
  Future<void> init() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final temporaryDirectory = await getTemporaryDirectory();
    Hive.init(appDocumentsDirectory.path);
    await Hive.openBox(HiveBoxes.news, path: temporaryDirectory.path);
  }
}
