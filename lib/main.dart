import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/routers/four_one_routers.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _routersDelegate = VxNavigator(
    routes: FourOneRouters.routers,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routersDelegate,
      routeInformationParser: VxInformationParser(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}