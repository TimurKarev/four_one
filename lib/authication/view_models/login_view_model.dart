import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/services/firebase_auth.dart';

final loginPageProvider = ChangeNotifierProvider((ref) => LoginViewModel(ref.read));

class LoginViewModel extends ChangeNotifier {

  final Reader read;
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

  LoginViewModel(this.read);

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
    final result = _verifyForm();
    notifyListeners();
    if (result) {
      if (loginPage) {
        _login();
      } else {
        _register();
      }
    }
  }

  bool _verifyForm() {
    if (mailController.text.isEmpty) {
      mailErrorString = 'Введите почту';
      return false;
    } else {
      final mailList = mailController.text.split('@');
      if (mailList.length != 2) {
        mailErrorString = 'Введите существующий адрес электронной почты';
        return false;
      } else {
        final tailList = mailList[1].split('.');
        if (tailList.length < 2) {
          mailErrorString = 'Введите существующий адрес электронной почты';
          return false;
        } else if (tailList.last.isEmpty) {
          mailErrorString = 'Введите существующий адрес электронной почты';
          return false;
        }
      }
    }
    if (password1Controller.text.isEmpty) {
      password1ErrorString = 'Введите пароль';
      return false;
    }
    if (loginPage) {
    } else {
      if (nameController.text.isEmpty) {
        nameErrorString = 'Введите имя';
        return false;
      }

      if (password1Controller.text != password2Controller.text &&
          password1Controller.text.isNotEmpty) {
        password1ErrorString = 'Пароли не совпадают';
        password2ErrorString = 'Пароли не совпадают';
        return false;
      }
    }
    return true;
  }

  Future<void> _register() async {
    final auth = read(authProvider);
    auth.createUserWithEmailAndPassword(
      email: mailController.text,
      password: password1Controller.text,
    );
  }

  void _login() {
    final auth = read(authProvider);
    auth.signInEmailAndPassword(
      email: mailController.text,
      password: password1Controller.text,
    );
  }
}
