import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';

void main() async{
  await GetStorage.init("auth");
  runApp(const App());
}
