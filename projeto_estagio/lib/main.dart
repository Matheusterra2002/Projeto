import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:projeto_estagio/RouteGenerator.dart';
import 'package:projeto_estagio/views/TelaInicial.dart';

final ThemeData temaPadrao =
    ThemeData(primaryColor: Color(0xFFE0FFFF), accentColor: Color(0xFFE0FFFF));
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "Projeto Estagio",
    home: TelaInicial(),
    theme: temaPadrao,
    initialRoute: "/Login",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
