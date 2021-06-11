import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/view_models/login_view_model.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  String? _errorString(String str) {
    if (str.isEmpty)
      return null;
    return str;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final provider = watch(loginPageProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(provider.titleString),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                provider.revertPage();
              },
              child: Text(
                provider.actionString,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (!provider.loginPage)
                TextFormField(
                  controller: provider.nameController,
                  decoration: InputDecoration(
                    labelText: 'Имя',
                    errorText: _errorString(provider.nameErrorString),
                  ),
                ),
              if (!provider.loginPage)
                SizedBox(
                  height: 30.0,
                ),
              TextFormField(
                controller: provider.mailController,
                decoration: InputDecoration(
                  labelText: 'Почта',
                  errorText: _errorString(provider.mailErrorString),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                obscureText: true,
                controller: provider.password1Controller,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  errorText: _errorString(provider.password1ErrorString),
                ),
              ),
              if (!provider.loginPage)
                SizedBox(
                  height: 30.0,
                ),
              if (!provider.loginPage)
                TextFormField(
                  obscureText: true,
                  controller: provider.password2Controller,
                  decoration: InputDecoration(
                    errorText: _errorString(provider.password2ErrorString),
                    labelText: 'Повторите пароль',
                  ),
                ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () {
                  provider.mainActionPressed();
                },
                child: Text(provider.buttonString),
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () {
                  provider.revertPage();
                },
                child: Text(provider.revButtonString),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
