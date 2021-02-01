import 'package:flutter/foundation.dart';
import 'package:read_it_later/handlers/storage_manager.handler.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkTheme;

  bool getIsDark() => _isDarkTheme;

  ThemeController() {
    try {
      StorageManager.readData('themeMode').then((value) {
        var themeMode = value ?? 'light';
        if (themeMode == 'light') {
          _isDarkTheme = false;
        } else {
          _isDarkTheme = true;
        }
        notifyListeners();
      });
    } catch (err) {}
  }

  void setDarkMode() async {
    _isDarkTheme = true;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _isDarkTheme = false;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  /// Utilizando o Design pattern singleton para assim poder
  /// utilizar a mesma instancia da classe em diferentes arquivos.
  /// Pois para que eu tenha uma constância das informações que eu
  /// estou trabalhando em diferentes widgets eu devo utizar a mesma
  /// instancia desse controller.
  static ThemeController instance = ThemeController();

  changeTheme() {
    _isDarkTheme ? setLightMode() : setDarkMode();
    notifyListeners();
  }
}
