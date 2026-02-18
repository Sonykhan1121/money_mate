import 'package:flutter/cupertino.dart';


class AddExpenseProvider extends ChangeNotifier {
  List<String> _tempImagePaths = [];

  List<String> get imagePaths => _tempImagePaths;

  void setImagePaths(List<String> val) {
    _tempImagePaths = val;
    notifyListeners();
  }
  void addImagePath(String path)
  {
    _tempImagePaths.add(path);
    notifyListeners();
  }
  void removeImagePath(int index)
  {
    _tempImagePaths.removeAt(index);
    notifyListeners();
  }
}
