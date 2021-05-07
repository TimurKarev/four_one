import 'package:flutter/material.dart';
import 'package:four_one/four_one/ui/create_entry_widget.dart';
import 'package:four_one/four_one/ui/table_screen_big.dart';

class FourOneRouters {
  static final routers = {
    '/' : (uri, params) => MaterialPage(child: TableScreenBig()),
    CreateEntryWidget.path : (uri, params) => MaterialPage(child: CreateEntryWidget()),
  };
}