import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteImage = [];
  List<String> get favoriteImage => _favoriteImage;

  void toggleFavorite(String imgUrl) {
    final isExist = _favoriteImage.contains(imgUrl);
    if (isExist) {
      _favoriteImage.remove(imgUrl);
    } else {
      _favoriteImage.add(imgUrl);
    }
    notifyListeners();
  }

  bool isFavorite(String imgUrl) {
    final isExist = _favoriteImage.contains(imgUrl);
    return isExist;
  }

  void clearFavorite() {
    _favoriteImage = [];
    notifyListeners();
  }
}
