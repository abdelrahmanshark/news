import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseService{
  late Box channelsBox;
  late Box newsBox;
  Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    Hive.init(appDocDir.path);
    channelsBox = await Hive.openBox('source');
    newsBox = await Hive.openBox('news', path: tempDir.path);
  }

}