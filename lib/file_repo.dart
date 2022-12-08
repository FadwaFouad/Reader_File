import 'package:shared_preferences/shared_preferences.dart';

class FileRepo {
  void saveFiles(List<String> files) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList("files", files);
  }

  Future<List<String>> getFiles() async {
    var prefs = await SharedPreferences.getInstance();
    List<String>? files = prefs.getStringList("files");
    return files ?? [];
  }

  Future<void> removeFile(String path) async {
    List<String> files = await getFiles();
    files.remove(path);
    saveFiles(files);
  }
}
