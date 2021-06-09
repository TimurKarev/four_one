import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginPageProvider = ChangeNotifierProvider((ref) => LoginViewModel());

class LoginViewModel extends ChangeNotifier {
  bool loginPage = true;
  String actionString = 'Зарегестрироватсья';
  String buttonString = 'Войти';
  String revButtonString = 'Нет пароля? Зарегестрироваться';
  String titleString = 'Войти в систему';

  String nameErrorString = '';
  String password1ErrorString = '';
  String password2ErrorString = '';
  String mailErrorString = '';

  TextEditingController mailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void revertPage() {
    loginPage = !loginPage;
    _resetPage();
    if (loginPage) {
      actionString = 'Зарегестрироватсья';
      buttonString = 'Войти';
      revButtonString = 'Нет пароля? Зарегестрироваться';
      titleString = 'Войти в систему';
    } else {
      actionString = 'Войти';
      buttonString = 'Зарегестрироваться';
      revButtonString = 'Есть пароль? Войти по паролю';
      titleString = 'Регистрация в системе';
    }
    notifyListeners();
  }

  void _resetPage() {
    _clearControllers();

    _clearErrorStrings();
  }

  void _clearErrorStrings() {
    nameErrorString = '';
    password1ErrorString = '';
    password2ErrorString = '';
    mailErrorString = '';
  }

  void _clearControllers() {
    mailController.clear();
    password1Controller.clear();
    password2Controller.clear();
    nameController.clear();
  }

  void mainActionPressed() {
    _clearErrorStrings();
    if (mailController.text.isEmpty) {
      mailErrorString = 'Введите почту';
      notifyListeners();
      return;
    } else {
      final mailList = mailController.text.split('@');
      if (mailList.length != 2) {
        mailErrorString = 'Введите существующий адрес электронной почты';
        notifyListeners();
        return;
      } else {
        final tailList = mailList[1].split('.');
        if (tailList.length < 2) {
          mailErrorString = 'Введите существующий адрес электронной почты';
          notifyListeners();
          return;
        } else if (tailList.last.isEmpty) {
          mailErrorString = 'Введите существующий адрес электронной почты';
          notifyListeners();
          return;
        }
      }
    }
    if (password1Controller.text.isEmpty) {
      password1ErrorString = 'Введите пароль';
      notifyListeners();
      return;
    }
    if (loginPage) {
    } else {
      if (nameController.text.isEmpty) {
        nameErrorString = 'Введите имя';
        notifyListeners();
        return;
      }

      if (password1Controller.text != password2Controller.text &&
          password1Controller.text.isNotEmpty) {
        password1ErrorString = 'Пароли не совпадают';
        password2ErrorString = 'Пароли не совпадают';
        notifyListeners();
        return;
      }
    }
    notifyListeners();
    if (loginPage) {
      _login();
    } else {
      _register();
    }
  }

  void _register() {
    print('_register');
  }

  void _login() {
    print('_login');
  }
}
